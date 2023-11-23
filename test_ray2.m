
%%
clear
close all


% Define the vertices of the house walls, roof, and floor
wall1 = [0,0,0; 1,0,0; 1,0,1; 0,0,1];
wall2 = [0,1,0; 0 1 1; 1 1 1; 1 1 0];
wall3 = [0,0,0; 0 0 1; 0 1 1; 0 1 0];
wall4 = [1,0,0; 1,1,0; 1,1,1; 1,0,1];
floor = [0,0,0; 1 0 0; 1 1 0; 0 1 0];
top =   [0,0,1; 1 0 1; 1 1 1; 0 1 1];
% Scaling factor for the house
scaling_factor = 1;

% Scale the vertices to create a larger house
wall1 = scaling_factor * wall1;
wall2 = scaling_factor * wall2;
wall3 = scaling_factor * wall3;
wall4 = scaling_factor * wall4;
floor = scaling_factor * floor;
top = scaling_factor * top;

% Create the room and add surfaces to it
room0 = room();
room0.add_surface(wall1, 0);
room0.add_surface(wall2, 0);
room0.add_surface(wall3, 0);
room0.add_surface(wall4, 0);
room0.add_surface(floor, 0);
room0.add_surface(top, 0);


% Plot the room
figure
room0.draw_room
title('House Model')
xlabel('x')
ylabel('y')
zlabel('z')


% Calculate the centroid of the house
all_vertices = [wall1; wall2; wall3; wall4];
centroid = mean(all_vertices);

% Create a source at the midpoint of the house
source_position = centroid;
source1 = source(source_position, [0, 0, 0], 1, 'monopole');
hold on
plot3(source_position(1),source_position(2),source_position(3),'.k','MarkerSize',25)
hold on

% Generate rays from the source
rayPackage = source1.GenerateRays();

fs = 44.1e3;
Nt = 1024;
freq = (0:Nt-1)/Nt*fs;

% Propagate the rays in the environment
Scheduler = scheduler(rayPackage, room0.surfaces, 1); %1 step
for n = 1 : 100
    Scheduler.propagate(); % Simulate ray propagation
end
% Display the propagated rays
hold on
%rayPackage.DrawRays();
title('House Model with Propagated Rays')
axis equal tight
view(3)

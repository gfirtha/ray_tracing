
%%
clear
close all
addpath('objects')

fs = 44.1e3;
Nt = 1024;
freq = (0:Nt-1)'/Nt*fs;
exc = ones(size(freq));


% Define the vertices of the house walls, roof, and floor
wall1 = [0,0,0; 1,0,0; 1,0,1; 0,0,1];
wall2 = [0,1,0; 0 1 1; 1 1 1; 1 1 0];
wall3 = [0,0,0; 0 0 1; 0 1 1; 0 1 0];
wall4 = [1,0,0; 1,1,0; 1,1,1; 1,0,1];
floor = [0,0,0; 1 0 0; 1 1 0; 0 1 0];
top =   [0,0,1; 1 0 1; 1 1 1; 0 1 1];
% Scaling factor for the house
scaling_factor = 4;

% Scale the vertices to create a larger house
wall1 = scaling_factor * wall1;
wall2 = scaling_factor * wall2;
wall3 = scaling_factor * wall3;
wall4 = scaling_factor * wall4;
floor = scaling_factor * floor;
top = scaling_factor * top;

% Create the room and add surfaces to it
room0 = room();
room0.add_surface(wall1,  'absorption_coef', zeros(size(freq)));
room0.add_surface(wall2,  'absorption_coef', zeros(size(freq)));
room0.add_surface(wall3,  'absorption_coef', zeros(size(freq)));
room0.add_surface(wall4,  'absorption_coef', zeros(size(freq)));
room0.add_surface(floor,  'absorption_coef', zeros(size(freq)));
room0.add_surface(top,  'absorption_coef', zeros(size(freq)));

%%
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
%%
% Create a source at the midpoint of the house
source_position = centroid;
Source = source(source_position, [0, 0, 0], 10, 'monopole', freq, exc);
%%
Nt = 2*fs;
Receiver = receiver(source_position+[0.1,0.1,0.1], 0.2, 'monopole', freq, Nt);
%%
rayPackage = ray_package(Source);
hold on
plot3(source_position(1),source_position(2),source_position(3),'.k','MarkerSize',25)
hold on
%%
% Propagate the rays in the environment
Scheduler = scheduler(rayPackage, room0.surfaces, Receiver, freq); 
for n = 1 : 4
    Scheduler.propagate(); % Simulate ray propagation
end
% Display the propagated rays
hold on
%rayPackage.DrawRays();
title('House Model with Propagated Rays')
axis equal tight
view(3)

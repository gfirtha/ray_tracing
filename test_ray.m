clear
close all
addpath('objects')


source1 = source([0,0,0]',[0,1,0]',500,'monopole');

rayPackage = source1.GenerateRays;
%%
figure
hold on
rayPackage.DrawRays;
axis equal tight

xlabel('X');
ylabel('Y');
zlabel('Z');
grid on;
view(3); % Adjust the view as needed.
%%
% Define the number of spheres
numSpheres = 10;

% Create an array to store sphere objects
spheres = my_sphere.empty(numSpheres, 0);

% Generate random spheres and store them in the array
for i = 1:numSpheres
    center = randi([-20, 20], 1, 3);  % Random center coordinates within the range
    radius = randi([1, 5]);  % Random radius between 1 and 5
    spheres(i) = my_sphere(center, radius);
end

% Plotting all spheres
figure;
hold on;
for i = 1:numSpheres
    spheres(i).draw();
end
axis equal;
xlabel('X');
ylabel('Y');
zlabel('Z');
grid on;
title('Multiple Random Spheres');
%%
clear
close all


% Define the vertices of the house walls, roof, and floor
wall1 = [0,0,0; 1,0,0; 1,0,1; 0,0,1];
wall2 = [0,1,0; 1,1,0; 1,1,1; 0,1,1];
wall3 = [0,0,0; 0,1,0; 0,1,1; 0,0,1];
wall4 = [1,0,0; 1,1,0; 1,1,1; 1,0,1];
floor = [0,0,0; 0,1,0; 1,1,0; 1,0,0];
roof1 = [1,0,1; 0,0,1; 0.5,0.5,1.5];
roof2 = [0,0,1; 0,1,1; 0.5,0.5,1.5];
roof3 = [0,1,1; 1,1,1; 0.5,0.5,1.5];
roof4 = [1,1,1; 1,0,1; 0.5,0.5,1.5];

% Scaling factor for the house
scaling_factor = 1;

% Scale the vertices to create a larger house
wall1 = scaling_factor * wall1;
wall2 = scaling_factor * wall2;
wall3 = scaling_factor * wall3;
wall4 = scaling_factor * wall4;
floor = scaling_factor * floor;
roof1 = scaling_factor * roof1;
roof2 = scaling_factor * roof2;
roof3 = scaling_factor * roof3;
roof4 = scaling_factor * roof4;

% Create the room and add surfaces to it
room0 = room();
room0.add_surface(wall1, 0);
room0.add_surface(wall2, 0);
room0.add_surface(wall3, 0);
room0.add_surface(wall4, 0);
room0.add_surface(roof1, 0);
room0.add_surface(roof2, 0);
room0.add_surface(roof3, 0);
room0.add_surface(roof4, 0);
room0.add_surface(floor, 0);



% Plot the room
figure
room0.draw_room
title('House Model')

% Calculate the centroid of the house
all_vertices = [wall1; wall2; wall3; wall4; floor; roof1; roof2; roof3; roof4];
centroid = mean(all_vertices);

% Create a source at the midpoint of the house
source_position = centroid;
source1 = source(source_position, [0, 0, 0], 2, 'monopole');

% % Create a source at a specific position
% source_position = [0.1, 0.1, 0.1];
% source1 = source(source_position, [0, 0, 0], 5e2, 'monopole');

% Generate rays from the source
rayPackage = source1.GenerateRays();

% Propagate the rays in the environment
Scheduler = scheduler(rayPackage, room0.surfaces, 1); %1 step
Scheduler.propagate(); % Simulate ray propagation

% Display the propagated rays
hold on
rayPackage.DrawRays();
title('House Model with Propagated Rays')



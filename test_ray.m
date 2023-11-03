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



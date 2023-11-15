%test_script
% Create a SoundSource
sourcePosition = [0; 0; 0]; % Source position at the origin
sourceOrientation = [1; 0; 0]; % Example orientation vector (change as needed)
rayNumbers = 10; % Number of rays to generate
soundSource = source(sourcePosition, sourceOrientation, rayNumbers);

% % Create a Receiver
% receiverPosition = [3; 0; 0]; % Receiver position
% receiverVolume = 1; % Receiver volume (radius)
% receiver_test = receiver(receiverVolume, receiverPosition);

% Generate rays and package them
rayPackage = ray_package();
rayPackage.source = soundSource;

% Generate and add rays to the ray_package using the GenerateRays_oriented function
rayPackage = soundSource.GenerateRays_oriented();

% Draw the rays contained in the Ray_package
rayPackage.DrawRays();

% Set up the figure for visualization
title('Visualization of 10 Rays');
axis equal; % Equal aspect ratio for 3D plot
xlabel('X');
ylabel('Y');
zlabel('Z');
grid on;



% % Create a Receiver figure and plot the receiver's position
% hold on;
% scatter3(receiverPosition(1), receiverPosition(2), receiverPosition(3), 'filled', 'MarkerFaceColor', 'r');

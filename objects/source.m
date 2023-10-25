classdef source < handle
    %SOURCE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        position
        orientation
        ray_no
    end
    
    methods
        function obj = source(position, orientation, ray_no)
            %SOURCE Construct an instance of this class
            %   Detailed explanation goes here
            obj.position = position;
            obj.orientation = orientation;
            obj.ray_no = ray_no;
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end

        function obj = SetPosition(obj, NewPosition)
            if numel(NewPosition)~=3
                error ('New position must have 3 coordinates!');
            end
            obj.position=NewPosition;
        end

        function obj = SetOrientation(obj, NewOrieantation)
            obj.position=NewOrieantation;
        end

        function obj = SetRay_no(obj, NewRay_no)
            obj.position=NewRay_no;
        end

          function RayPackage = GenerateRays_spherical(obj)
           % Generate sound rays from the source in all directions (3D sphere)
            numRays=obj.ray_no;
            RayPackage=ray_package();
            RayPackage.source=obj;
            RayPackage.rays=[];

           for i = 1:numRays
                % Generate random spherical coordinates (azimuth and elevation).
                azimuth = 2 * pi * rand(); % Random azimuth angle [0, 2*pi]
                elevation = asin(2 * rand() - 1); % Random elevation angle [-pi/2, pi/2]

                % Convert spherical coordinates to a 3D direction vector.
                x = cos(azimuth) * cos(elevation);
                y = sin(azimuth) * cos(elevation);
                z = sin(elevation);
                currentDirection = [x; y; z];

           % Create a new ray object and add it to the Ray_package.
                newRay = ray();
                newRay.direction = currentDirection;
                newRay.propagation_time = 0; % Initialize propagation time
                newRay.frequency = 0; % Initialize frequency
                newRay.amplitude = 0; % Initialize amplitude
                newRay.curvature = 0; % Initialize curvature
                RayPackage.rays = [RayPackage.rays, newRay];
            end
          end

          function rayPackage = GenerateRays_oriented(obj)
            % Generate sound rays from the source around the specified orientation.

            
            % Determine the number of rays to generate.
            numRays = obj.ray_no;
            
            % Create a Ray_package to store the generated rays.
            rayPackage = ray_package();
            rayPackage.source = obj;
            rayPackage.rays = [];
            
            % Generate rays around the specified orientation.
            for i = 1:numRays
                % Generate small variations in direction around the orientation.
                angleVariation = 2 * pi * (rand() - 0.5); % Random angle variation [-pi, pi]
                
                % Rotate the orientation by the angle variation.
                rotatedDirection = RotateVector(obj.orientation, [0; 0; 1], angleVariation);
                
                % Create a new ray object and add it to the Ray_package.
                newRay = ray();
                newRay.direction = rotatedDirection;
                newRay.propagation_time = 0; % Initialize propagation time
                newRay.frequency = 0; % Initialize frequency
                newRay.amplitude = 0; % Initialize amplitude
                newRay.curvature = 0; % Initialize curvature
                rayPackage.rays = [rayPackage.rays, newRay];
            end
            
        end
    end
end


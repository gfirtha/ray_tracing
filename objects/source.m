classdef source < handle
    %SOURCE Summary of this class goes here
    %   Detailed explanation goes here

    properties
        position
        orientation
        ray_no
        dirchar
    end

    methods
        function obj = source(position, orientation, ray_no, dirchar)
            %SOURCE Construct an instance of this class
            %   Detailed explanation goes here
            obj.position = position;
            obj.orientation = orientation;
            obj.ray_no = ray_no;
            switch dirchar
                case 'monopole'
                    obj.dirchar = @(x) x;
                case 'dipole'
                    obj.dirchar = @(x) cos(x);
            end
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
                newRay = ray(obj.position, currentDirection , 0, [] , obj.dirchar(azimuth), inf);
                RayPackage.add_ray(newRay);
            end
        end

        function rotatedVector = CustomRotateVector(vector, axis, angle)
            % Rotate a 3D vector around a specified axis by a given angle (in radians).

            % Ensure the input vector and axis are 3D vectors.
            assert(all(size(vector) == [3 1]) && all(size(axis) == [3 1]), 'Input vectors must be 3D.');

            R = [cos(angle), -sin(angle), 0;
                sin(angle), cos(angle), 0;
                0, 0, 1];


            % Apply the rotation matrix to the vector.
            rotatedVector = R * vector;
        end


    end

end


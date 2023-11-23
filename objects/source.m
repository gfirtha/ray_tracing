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
                    obj.dirchar = @(x) 1;
                case 'dipole'
                    obj.dirchar = @(x) cos(x);
                case 'quadrupole'
                    obj.dirchar = @(x) cos(2*x);
                case 'cardioid'
                    obj.dirchar = @(x) 1+cos(x);
                case 'hypercardioid'
                    obj.dirchar = @(x) 1+cos(x)-(1/2)*cos(x);
            end
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

        function RayPackage = GenerateRays(obj)
            % Generate sound rays from the source in all directions (3D sphere)
            RayPackage = ray_package();
            RayPackage.source=obj;

            for i = 1:obj.ray_no
                % Generate random spherical coordinates (azimuth and elevation).
                azimuth = 2 * pi * rand(); % Random azimuth angle [0, 2*pi]
                elevation = asin(2 * rand() - 1); % Random elevation angle [-pi/2, pi/2]

                % Convert spherical coordinates to a 3D direction vector.
                x = cos(azimuth) * cos(elevation);
                y = sin(azimuth) * cos(elevation);
                z = sin(elevation);
                currentDirection = [x; y; z];
                % Create a new ray object and add it to the Ray_package.
                newRay = ray(obj.position, currentDirection , 0, [] , obj.dirchar(azimuth), inf,0);
                RayPackage.add_ray(newRay); %ide a konstruktorba kéne megadni a frek tengelyt nem?
            end
        end


    end

end


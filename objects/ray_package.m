classdef ray_package < handle
    %RAY_PACKAGE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        source
        rays
    end
    
    methods
        
        function obj = ray_package(source_in)
            obj.source = source_in;
            obj.rays = [];
            obj.GenerateRays(obj.source);
        end


        function obj = GenerateRays(obj,source)
            % Generate sound rays from the source in all directions (3D sphere)

            for i = 1:source.ray_no
                % Generate random spherical coordinates (azimuth and elevation).
                azimuth = 2 * pi * rand(); % Random azimuth angle [0, 2*pi]
                elevation = asin(2 * rand() - 1); % Random elevation angle [-pi/2, pi/2]
                [x,y,z] = sph2cart(azimuth,elevation,1);

                % Create a new ray object and add it to the Ray_package.
                newRay = ray(source.position, [x,y,z]' , 0, source.excitation_signal*source.dirchar(azimuth), inf,0);
                obj.add_ray(newRay);
            end
        end
        function EliminateRays(obj)
           RayEnergy = sqrt(sum( (abs([obj.rays(:).amplitude])).^2,1));
           eps = 1e-6;
           obj.rays(RayEnergy<eps) = [];
        end



         function allRays = getRays(obj)
            % Getter function for all rays within the ray package
            allRays = obj.rays;
        end
        
        function setRays(obj, newRays)
            % Setter function for all rays within the ray package
            obj.rays = newRays;
        end

         function rayDirection = getRayDirection(obj, rayIndex)
            % Getter function for the direction of a specific ray
            rayDirection = obj.rays(rayIndex).direction;
        end
        
        function setRayDirection(obj, rayIndex, newDirection)
            % Setter function for the direction of a specific ray
            obj.rays(rayIndex).direction = newDirection;
        end
        
        function rayOrigin = getRayOrigin(obj, rayIndex)
            % Getter function for the origin of a specific ray
            rayOrigin = obj.rays(rayIndex).origin;
        end
        
        function setRayOrigin(obj, rayIndex, newOrigin)
            % Setter function for the origin of a specific ray
            obj.rays(rayIndex).origin = newOrigin;
        end

        function rayAmplitude = getRayAmplitude(obj, rayIndex)
            rayAmplitude=obj.rays(rayIndex).amplitude;
        end



        function obj = add_ray(obj, ray_in)
                obj.rays = [obj.rays, ray_in];
        end

        function EliminateAllRays(obj)
            for i = 1:nume1(obj.rays)
                ray = obj.rays(i);
                ray.EliminiateRay();
            end
        end
          function DrawRays(obj)
            % Draw all rays contained in the Ray_package.
            sourcePosition = obj.source.position;

            for i = 1:numel(obj.rays)
                ray = obj.rays(i);
                ray.PlotRay(sourcePosition); 
            end
        end
        
    end
end


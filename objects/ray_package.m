classdef ray_package < handle
    %RAY_PACKAGE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        source
        rays
    end
    
    methods
        function obj = ray_package(source_in)
            if nargin==0
                obj.source=[];
                obj.rays=[];
        else
            obj.source = source_in;
            obj.rays=[];
        end
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
        function EliminateRay(obj)
           eps = 1e-6;
           RMS = rms(getRayAmplitude(obj,rayIndex));
            if RMS < eps
                obj.rays(rayIndex) = [];
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


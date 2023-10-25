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

        function obj = add_ray(obj, ray_in)
                obj.rays = [obj.rays, ray_in];
        end

          function DrawRays(obj)
            % Draw all rays contained in the Ray_package.
            sourcePosition = obj.source.position;

            for i = 1:numel(obj.rays)
                ray = obj.rays(i);
                ray.PlotRay(sourcePosition); 
            end

            xlabel('X');
            ylabel('Y');
            zlabel('Z');
            grid on;
            view(3); % Adjust the view as needed.
        end
        
    end
end


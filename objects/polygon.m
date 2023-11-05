classdef polygon < surface
    %RECTANGLE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj = polygon(vx,alpha)
            %RECTANGLE Construct an instance of this class
            %   Detailed explanation goes here
            obj = obj@surface(vx,alpha);
        end
        
         function intersection = intersect(obj, ray_origin, ray_direction)
            % Calculate the intersection of the ray with the plane defined by the vertices of the polygon
            
            % Calculate the plane defined by the vertices
            normal = cross(obj.vertices(2, :) - obj.vertices(1, :), obj.vertices(3, :) - obj.vertices(1, :));
            normal = normal / norm(normal);
            
            % Calculate the intersection of the ray with the plane
            denom = dot(normal, ray_direction);
            
            if abs(denom) > 0.0001  % Avoiding division by close-to-zero values
                t = dot(obj.vertices(1, :) - ray_origin, normal) / denom;
                intersection = ray_origin + t * ray_direction;
            else
                intersection = nan; 
            end
         end
        
        

                function reflect(obj, ray)
            % Reflects the incoming ray from the plane
            
            % Calculate the normal to the polygon at the intersection point
            normal = obj.CalculateNormal(ray.intersection_point);
            
            % Compute the reflected direction using the incoming direction and the surface normal
            ray.direction = obj.ComputeReflectedDirection(ray.direction, normal);
        end
        
        function newDirection = ComputeReflectedDirection(obj, incidentDirection, surfaceNormal)
            % Compute the reflected direction based on incoming direction and surface normal

            % Make sure incoming and normal vectors are unit vectors
            incidentDirection = incidentDirection / norm(incidentDirection);
            surfaceNormal = surfaceNormal / norm(surfaceNormal);

            % Calculate the reflected direction
            newDirection = incidentDirection - 2 * dot(incidentDirection, surfaceNormal) * surfaceNormal;
        end
        
        function normal = CalculateNormal(obj, intersection_point)
            % Assuming that the vertices define a planar polygon and the normal is perpendicular to the plane
            % Using cross product to find the normal vector
            
            % For simplicity, assuming the average normal if there's no specific intersection point
            if ~exist('intersection_point', 'var')
                normal = cross(obj.vertices(2, :) - obj.vertices(1, :), obj.vertices(3, :) - obj.vertices(1, :));
            else
                % Calculate a normal based on the provided intersection point
                % Example calculation using the vertices, you might need a different method
                v1 = obj.vertices(2, :) - obj.vertices(1, :);
                v2 = obj.vertices(3, :) - obj.vertices(1, :);
                avg_normal = cross(v1, v2);
                
                % Another method could involve finding the closest vertices to the intersection point and using them to calculate the normal.
                
                % Assign the average normal if a specific intersection point is not provided
                normal = avg_normal;
            end
        end




















        function draw_surface(obj, transparency)
    % Default transparency value
    if nargin < 2
        transparency = 0.5; % Set your desired transparency level here
    end

    patch(obj.vertices(:,1), obj.vertices(:,2), obj.vertices(:,3), 'red', 'FaceAlpha', transparency);
end

    end
end
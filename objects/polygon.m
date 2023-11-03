classdef polygon < surface
    %RECTANGLE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
     
    end
    
    methods
        function obj = polygon(vertices, absorption_coeff)
            %SURFACE Construct an instance of this class
            %   Detailed explanation goes here
            obj.vertices=vertices;
            obj.absorption_coeff=absorption_coeff;
            
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
                intersection = []; % Ray is parallel to the plane
            end
         end
        
         function normal = CalculateNormal(obj, intersection_point)
            % Assuming that the vertices define a planar polygon and the normal is perpendicular to the plane
            % Using cross product to find the normal vector
            v1 = obj.Vertices(2, :) - obj.Vertices(1, :);
            v2 = obj.Vertices(3, :) - obj.Vertices(1, :);
            normal = cross(v1, v2);
        end

        function draw_surface(obj)
            patch(obj.vertices(:,1),obj.vertices(:,2), obj.vertices(:,3),'red')
        end
    end
end


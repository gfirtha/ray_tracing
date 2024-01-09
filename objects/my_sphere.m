classdef my_sphere < surface
    properties
        center
        radius
    end
    
    methods
        function obj = my_sphere(center, radius, BC_type,BC_val)
            obj = obj@surface(BC_type,BC_val);
            obj.center = center;
            obj.radius = radius;
        end
        
        function normal = CalculateNormal(obj, intersectionPoint)
            % For a sphere, the normal at any point on the surface is the vector from the center to that point
            normal = (intersectionPoint - obj.center) / norm(intersectionPoint - obj.center);
        end

        function intersection = intersect(obj, ray_origin, ray_direction)
            % Calculate the intersection of the ray with the sphere
            oc = ray_origin - obj.center;
            a = dot(ray_direction, ray_direction);
            b = 2.0 * dot(oc, ray_direction);
            c = dot(oc, oc) - obj.radius * obj.radius;
            discriminant = b * b - 4 * a * c;
            
            if discriminant < 0
                intersection = []; % No real roots, no intersection
            else
                root = sqrt(discriminant);
                t = (-b - root) / (2.0 * a);
                if t > 0
                    intersection = ray_origin + t * ray_direction;
                else
                    intersection = []; % Intersection behind the ray origin
                end
            end
         end

         function reflect(obj, ray, intersection)
            v = ray.direction - ray.origin;
            x = intersection;
            c = obj.center;
            w = 2*dot(v,x-c)*(x-c)-v;
            ray.setDirection(w);
            ray.setOirigin(intersection);
         end

        function draw_surface(obj)
            [x, y, z] = sphere; % MATLAB's sphere function to get the coordinates
            x = x * obj.radius + obj.vertices(1);
            y = y * obj.radius + obj.vertices(2);
            z = z * obj.radius + obj.vertices(3);
            surf(x, y, z);
            axis equal tight;
        end
    end
end

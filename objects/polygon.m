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

        function intersection = intersect(obj, ray)
            % Calculate the intersection of the ray with the polygon
            intersection = [];
            p0 = obj.vertices(1,:)';
            l = ray.direction;
            l0 = ray.origin';
            p1 = obj.vertices(2, :) - obj.vertices(1, :);
            p2 = obj.vertices(end, :) - obj.vertices(1, :);
            p1 = p1 / norm(p1);
            p2 = p2 / norm(p2);
            n = cross(p1, p2);
            n = n' / norm(n);

            % Calculate the intersection of the ray with the plane
            d = dot((p0-l0),n)/dot(n,l);
            if d>0
                P0 =  l0 + l*d;
                B = [p1' p2' n];
                xv =  B\obj.vertices';
                xq = B\P0;
                is_in = inpolygon(xq(1),xq(2),xv(1,:),xv(2,:));
                if is_in
                    intersection = P0;
                    hold on
                    plot3(intersection(1),intersection(2),intersection(3),'.k','MarkerSize',5)
                    ray.PlotRay(intersection)
                end
            end
        end

        function reflect(obj, ray, intersection)
            % Reflects the incoming ray from the plane
            p1 = obj.vertices(2, :) - obj.vertices(1, :);
            p2 = obj.vertices(end, :) - obj.vertices(1, :);
            p1 = p1 / norm(p1);
            p2 = p2 / norm(p2);
            n = cross(p1, p2);
            n = n' / norm(n);
            l = ray.getDirection;
            r = l - 2 * dot(l,n)*n;
            ray.setDirection(r);
            ray.setOrigin(intersection');
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
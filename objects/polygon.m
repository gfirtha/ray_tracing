classdef polygon < surface
    %RECTANGLE Summary of this class goes here
    %   Detailed explanation goes here

    properties
    end

    methods
        function obj = polygon(vx,alpha,imp,R)
            obj = obj@surface(vx,alpha,imp,R);
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


        function draw_surface(obj, transparency)
            if nargin < 2
                transparency = 0.5; % Set your desired transparency level here
            end

            patch(obj.vertices(:,1), obj.vertices(:,2), obj.vertices(:,3), 'red', 'FaceAlpha', transparency);
        end

    end
end
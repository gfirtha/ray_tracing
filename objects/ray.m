classdef ray < handle
    %RAY Summary of this class goes here
    %   Detailed explanation goes here

    properties
        origin
        direction
        propagation_time
        frequency
        amplitude
        curvature
        intersection_point
    end

    methods
        function obj = ray(origin,direction,propagation_time,frequency,amplitude,curvature)
            %RAY Construct an instance of this class
            obj.origin = origin;
            obj.direction = direction;
            obj.propagation_time=propagation_time;
            obj.frequency=frequency;
            obj.amplitude=amplitude;
            obj.curvature=curvature;
        end

        function propagate(obj, surfaces, scheduler)
            % Given the surfaces in the environment, propagate the ray in one time step until it hits a surface.
            intersection = false;
            time_step = scheduler.time_step;

            while ~intersection
                % Calculate the next step based on the ray's direction and current position
                next_position = obj.origin + obj.direction * time_step;

                % Check for intersection with any surface
                for i = 1:numel(surfaces)
                    if surfaces(i).intersect(next_position, obj.direction)
                        % Set the new origin of the ray to the intersection point
                        obj.origin = surfaces(i).intersection_point;
                        intersection = true;
                        break;
                    end
                end

                % Update the ray's position for the next step
                if ~intersection
                    obj.origin = next_position;
                end
            end


            % Update the ray's position for the next step
            if (~intersection)
                obj.origin = next_position;
            end
        end


        function PlotRay(obj, origin)
            % Calculate the end point of the ray.
            endPoint = origin + abs(obj.amplitude)* obj.direction;

            % Plot the ray using quiver.
            quiver3(origin(1), origin(2), origin(3), endPoint(1) - origin(1), endPoint(2) - origin(2), endPoint(3) - origin(3), 0,'k');
        end
    end
end
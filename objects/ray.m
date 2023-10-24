classdef ray < handle
    %RAY Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        direction
        propagation_time
        frequency
        amplitude
        curvature
    end
    
    methods
        function obj = ray(direction,propagation_time,frequency,amplitude,curvature)
            %RAY Construct an instance of this class
            %   Detailed explanation goes here
            obj.direction = direction;
            obj.propagation_time=propagation_time;
            obj.frequency=frequency;
            obj.amplitude=amplitude;
            obj.curvature=curvature;
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;


        end

         function PlotRay(obj, origin, rayLength)
            % Calculate the end point of the ray.
            endPoint = origin + rayLength * obj.direction;

            % Plot the ray using quiver.
            quiver3(origin(1), origin(2), origin(3), endPoint(1) - origin(1), endPoint(2) - origin(2), endPoint(3) - origin(3), 0);
        end

    end
end


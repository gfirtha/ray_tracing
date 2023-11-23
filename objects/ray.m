classdef ray < handle

    properties
        origin
        direction
        propagation_time
        distance
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


        function rayDirection = getDirection(obj)
            % Getter function for the direction of the ray
            rayDirection = obj.direction;
        end

        function rayOrigin = getOrigin(obj)
            % Getter function for the origin of the ray
            rayOrigin = obj.origin;
        end

        function setDirection(obj, newDirection)
            % Setter function for the direction of the ray
            obj.direction = newDirection;
        end

        function setOrigin(obj, newOrigin)
            % Setter function for the origin of the ray
            obj.origin = newOrigin;
        end

        function EliminateRay(obj)
            eps=[];
                if obj.amplitude<eps
                obj=[];
            end
        end
        
        function decay_factor = CalcDecayFactor(obj,propagation_time,frequency)
            obj.distance=obj.intersection_point-obj.origin; %ha ez úgyis mindig csak reflectelés-kor lesz meghívva akkor issue lehet
            obj.amplitude=obj.amplitude/obj.distance^2;
        end
        
        function PlotRay(obj, varargin)
             if length(varargin) == 0
                % Calculate the end point of the ray.
                endPoint = obj.origin + abs(obj.amplitude)* obj.direction;
            elseif length(varargin) == 1
                endPoint = varargin{1};
            end
            % Plot the ray using quiver.
            quiver3(obj.origin(1), obj.origin(2), obj.origin(3), endPoint(1) - obj.origin(1), endPoint(2) - obj.origin(2), endPoint(3) - obj.origin(3), 0,'k');
        end
    end
end
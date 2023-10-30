classdef surface < room
    %SURFACE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        vertices
        absorption_coeff
    end
    
    methods
        function obj = surface(vertices, absorption_coeff)
            %SURFACE Construct an instance of this class
            %   Detailed explanation goes here
            obj.vertices=vertices;
            obj.absorption_coeff=absorption_coeff;
            
        end

        function newDirection = ComputeReflectedDirection(incidentDirection, surfaceNormal)
    % Compute the reflected direction based on incoming direction and surface normal

    % Make sure incoming and normal vectors are unit vectors
    incidentDirection = incidentDirection / norm(incidentDirection);
    surfaceNormal = surfaceNormal / norm(surfaceNormal);

    % Calculate the reflected direction
    newDirection = incidentDirection - 2 * dot(incidentDirection, surfaceNormal) * surfaceNormal;
        end

        
        function ReflectRay(obj, ray)
            % Compute reflection of the incoming ray

            % Find the normal vector of the surface at the intersection point
            normal = obj.CalculateNormal(ray.intersection_point);

            % Compute the reflected direction using the incoming direction and the surface normal
            ray.direction = ComputeReflectedDirection(ray.direction, normal);
        end

    end
    methods (Abstract)
            draw_surface()
           % reflect()
    end
end


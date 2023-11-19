classdef surface < room
    %SURFACE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        vertices
        absorption_coeff
    end
    
    methods
        function obj = surface(vertices, absorption_coeff)
            obj.vertices=vertices;
            obj.absorption_coeff=absorption_coeff;
            
        end
 
    end
    methods (Abstract)
            draw_surface()
            intersect()
            reflect()
            % CalculateNormal()
            % ComputeReflectedDirection()
    end
end
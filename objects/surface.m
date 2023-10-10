classdef surface < room
    %SURFACE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        vertices
        absorption_coeff
    end
    
    methods
        function obj = surface()
            %SURFACE Construct an instance of this class
            %   Detailed explanation goes here
        end
    end
    methods (Abstract)
            draw_surface()
           % reflect()
    end
end


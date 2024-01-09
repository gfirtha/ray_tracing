classdef surface < handle
    %SURFACE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        impedance
        reflection_coeff
        absorption_coeff
    end
    
    methods
        function obj = surface(BC_type, BC_value)
            c = 343;
            rho0 = 1.2;
            Z0 = rho0*c;
            switch BC_type
                case 'absorption_coef'
                    obj.absorption_coeff = BC_value;
                    obj.impedance = 1e20*ones(size(obj.absorption_coeff));
                    obj.reflection_coeff = ones(size(obj.absorption_coeff));
                    %TODO
                case 'impedance'
                    obj.impedance = BC_value;
                    obj.reflection_coeff = (obj.impedance-Z0)./(obj.impedance+Z0);
                    obj.absorption_coeff = 1 - abs(obj.reflection_coeff).^2;
                case 'reflection_coef'
                    obj.reflection_coeff = BC_value;
                    obj.impedance = Z0*(1+obj.reflection_coeff)./(1-obj.reflection_coeff);
                    obj.absorption_coeff = 1 - abs(obj.reflection_coeff).^2;
                case 'receiver'
                    obj.reflection_coeff = [];
                    obj.impedance = [];
                    obj.absorption_coeff = [];
            end
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
classdef polygon < surface
    %RECTANGLE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj = polygon(vx)
            %RECTANGLE Construct an instance of this class
            %   Detailed explanation goes here
            obj.vertices = vx;
        end
        
        function draw_surface(obj)
            patch(obj.vertices(:,1),obj.vertices(:,2), obj.vertices(:,3),'red')
        end
    end
end


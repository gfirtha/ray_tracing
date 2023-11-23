classdef room < handle
    %ROOM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        surfaces
        speed_of_sound
    end
    
    methods
        function obj = room()
            obj.surfaces = {};
            obj.speed_of_sound = 343;
        end
        
        function add_surface(obj,vx, alpha,imp,R)
            N = length(obj.surfaces);
            obj.surfaces{N+1} = polygon(vx,alpha,imp,R);
         end

        function draw_room(obj)
            for n = 1 : length(obj.surfaces)
                obj.surfaces{n}.draw_surface;
            end
        end
    end
end


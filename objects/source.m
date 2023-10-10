classdef source < handle
    %SOURCE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        position
        orientation
        ray_no
    end
    
    methods
        function obj = source(position, orientation, ray_no)
            %SOURCE Construct an instance of this class
            %   Detailed explanation goes here
            obj.position = position;
            obj.orientation = orientation;
            obj.ray_no = ray_no;
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end


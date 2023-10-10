classdef ray_package < handle
    %RAY_PACKAGE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        source
        rays
    end
    
    methods
        function obj = ray_package(source_in)
            %RAY_PACKAGE Construct an instance of this class
            %   Detailed explanation goes here
            obj.source = source_in;
            
        end
        
        function obj = step_time(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end


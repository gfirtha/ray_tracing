classdef source < handle
    %SOURCE Summary of this class goes here
    %   Detailed explanation goes here

    properties
        position
        orientation
        frequency          
        excitation_signal
        ray_no
        dirchar
    end

    methods
        function [obj] = source(position, orientation, ray_no, dirchar,freq,excitation)
            %SOURCE Construct an instance of this class
            %   Detailed explanation goes here
            obj.position = position;
            obj.orientation = orientation;
            obj.ray_no = ray_no;
            obj.frequency = freq;
            obj.excitation_signal = excitation;
            switch dirchar
                case 'monopole'
                    obj.dirchar = @(x) 1;
                case 'dipole'
                    obj.dirchar = @(x) cos(x);
                case 'quadrupole'
                    obj.dirchar = @(x) cos(2*x);
                case 'cardioid'
                    obj.dirchar = @(x) 1+cos(x);
                case 'hypercardioid'
                    obj.dirchar = @(x) 1+cos(x)-(1/2)*cos(x);
            end
            
        end


        function obj = SetPosition(obj, NewPosition)
            if numel(NewPosition)~=3
                error ('New position must have 3 coordinates!');
            end
            obj.position=NewPosition;
        end

        function obj = SetOrientation(obj, NewOrieantation)
            obj.position=NewOrieantation;
        end

        function obj = SetRay_no(obj, NewRay_no)
            obj.position=NewRay_no;
        end

    end

end


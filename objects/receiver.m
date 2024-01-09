classdef receiver < my_sphere
    properties
        ray_counter
        mic_chars 
        output_signal
        fs
    end
    
    methods

        function obj = receiver(center,radius, micChars, freq, Nt)
                obj = obj@my_sphere(center,radius, 'receiver',[]);
                switch micChars
                case 'monopole'
                    obj.mic_chars = @(x) 1;
                case 'dipole'
                    obj.mic_chars = @(x) cos(x);
                case 'cardioid'
                    obj.mic_chars = @(x) 1+cos(x);
                case 'hypercardioid'
                    obj.mic_chars = @(x) 1+cos(x)-(1/2)*cos(x);
                end 
                obj.ray_counter = 0; % Initialize the ray counter
                Nf = length(freq);
                obj.fs = max(freq)*Nf/(Nf-1);
                obj.output_signal = zeros(Nt,1);
           
        end

        function ReceiveRay(obj, ray_origin,ray_direction)
            % Check if the ray intersects the volume of the receiver.
            if ~isempty(obj.intersect(obj,ray_origin,ray_direction))
                % Increment the ray counter.
                obj.ray_counter = obj.ray_counter + 1;

            end
         end      

    end
end

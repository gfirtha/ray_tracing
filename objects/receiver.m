classdef receiver < handle
    properties
        volume
        ray_counter
        position
        mic_chars 
    end
    
    methods

        function obj = receiver(volume, position, micChars)
            if nargin == 3
                obj.volume = volume;
                obj.position = position;
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
            else
                error('Receiver properties (volume, position, mic_chars) must be provided.');
            end
        end

         function ReceiveRay(obj, ray)
            % Check if the ray intersects the volume of the receiver.
            if IsInsideReceiverVolume(ray, obj)
                % Increment the ray counter.
                obj.ray_counter = obj.ray_counter + 1;

            end
        end
        
      function isInside = IsInsideReceiverVolume(ray,source, obj)
    % Check if the ray intersects the spherical volume of the receiver.
    
    rayToReceiver = obj.Position - source.position;
    
    % Calculate the distance from the ray origin to the receiver's center.
    distance = norm(rayToReceiver);
    
    % Check if the distance is less than or equal to the radius of the receiver.
    isInside = distance <= obj.volume; % Assuming obj.Volume represents the radius of the spherical receiver.
        end


       
    end
end

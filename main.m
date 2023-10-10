clear
close all

vx1 = [0,0,0; ...
        1,0,0; ...
        1,0,1; ...
        0,0,1];
vx2 = [0,1,0; ...
        1,1,0; ...
        1,1,1; ...
        0,1,1];
vx3 = [0,0,0; ...
        0,1,0; ...
        0,1,1; ...
        0,0,1];
vx4 = [1,0,0; ...
        1,1,0; ...
        1,1,1; ...
        1,0,1];
roof1 = [1,0,1; ...
         0,0,1; ...
         0.5,0.5,1.5];
roof2 = [0,0,1; ...
         0,1,1; ...
         0.5,0.5,1.5];
roof3 = [0,1,1; ...
         1,1,1; ...
         0.5,0.5,1.5];
roof4 = [1,1,1; ...
         1,0,1; ...
         0.5,0.5,1.5];
room0 = room();
room0.add_surface(vx1);
room0.add_surface(vx2);
room0.add_surface(vx3);
room0.add_surface(vx4);
room0.add_surface(roof1)
room0.add_surface(roof2)
room0.add_surface(roof3)
room0.add_surface(roof4)
figure
room0.draw_room
clear all
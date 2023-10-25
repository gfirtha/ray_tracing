clear
close all
addpath('objects')

source1 = source([0,0,0]',[0,1,0]',1000,'dipole');

rayPackage = source1.GenerateRays_spherical;
%%
figure
hold on
rayPackage.DrawRays;
axis equal tight
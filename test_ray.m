clear
close all
addpath('objects')

source1 = source([0,0,0]',[0,1,0]',500,'quadrupole');

rayPackage = source1.GenerateRays;
%%
figure
hold on
rayPackage.DrawRays;
axis equal tight
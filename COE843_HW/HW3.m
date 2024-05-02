%% Problem 1.

% Compute Intersection point using cross product

L1 = [0.5 1 -2];
L2 = [3 6 -5];

X = cross (L1, L2);

disp (X);
%%

I = [0 0 1];
verify = dot (X, I);
disp (verify);

%% Problem 5 
% United States Population
us_pop = [75.995, 91.972, 105.711, 123.203, 131.669, 150.697, ...
    179.323, 203.212, 226.505, 249.633, 281.422, 308.748]';

% Year (1900-2010)
year = (1900:10:2010)';

% Matrix for linear and quadratic models
arr = [ones(length(year), 1), (year - 1960) / 60];

% Linear & % Quadratic model
linear = arr \ us_pop;
quadratic = [arr, ((year - 1960)/60).^2] \ us_pop;

% Plot of linear Model
subplot(2, 1, 1);
plot(year, us_pop, 'bo');
title('Linear Model of United States Population from 1910-2000');
xlabel('Year');
ylabel('Population (Millions)');
hold on
plot(year,arr*linear,'k-');
hold off

% Plot of quadratic Model
subplot(2, 1, 2);
plot(year, us_pop, 'bo');
title('Quadratic Model of United States Population from 1910-2000');
xlabel('Year');
ylabel('Population (Millions)');
hold on
plot(year, [arr, ((year - 1960)/60).^2]*quadratic, 'r--');
hold off

%%
openExample('vision/DetectSphereInPointCloudExample')
%%

load("object3d.mat");
% Loading a point cloud into the workspace from dataset 'object3d.mat’.
load("object3d.mat");
% Label and Display of point cloud.
figure
pcshow(ptCloud)
xlabel("X(m)")
ylabel("Y(m)")
zlabel("Z(m)")
title("Detect a sphere in a point cloud")
% Set of the maximum point-to-sphere distance for sphere fitting to 1cm.
maxDistance = 0.01;
% Set of the region of interest to constrain the search.
roi = [-inf,0.5;0.2,0.4;0.1,inf];
sampleIndices = findPointsInROI(ptCloud,roi);
% Detection of the globe in the point cloud and extract it.
[model,inlierIndices] = pcfitsphere(ptCloud,maxDistance,SampleIndices=sampleIndices);
globe = select(ptCloud,inlierIndices);
% Plot of the extracted globe.
figure;
pcshow(globe);
title("Globe Point Cloud");

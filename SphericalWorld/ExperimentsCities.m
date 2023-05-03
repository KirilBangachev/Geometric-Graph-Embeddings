city_locations =  importdata("city_loactions")
[n,d] = size(city_locations)
[Graph, NoisyGraph] = GraphOfX(city_locations, 0);

%% Experiments_20
beta = 30;
Graph_20 = Graph(1:20,1:20);
[Xhat_20,GraphHat_20] = Recovery(Graph_20,d,beta);
save("inferred_city_locations_20.txt","Xhat_20","-ascii")
%% Experiments_80
beta = 30;
Graph_80 = Graph(1:80,1:80);
[Xhat_80,GraphHat_80] = Recovery(Graph_80,d,beta);
save("inferred_city_locations_80.txt","Xhat_80","-ascii")
%% Experiments_320
beta = 30;
Graph_320 = Graph(1:320,1:320);
[Xhat_320,GraphHat_320] = Recovery(Graph_320,d,beta);
save("inferred_city_locations_320.txt","Xhat_320","-ascii")
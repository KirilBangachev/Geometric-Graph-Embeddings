debiased_city_locations =  importdata("City Data/debiased_city_loactions.txt")';
biased_city_locations =  importdata("City Data/biased_city_loactions.txt")';
uniform_data_set_city_locations =  importdata("City Data/uniform_data_set_city_loactions.txt")';
[d,n] = size(debiased_city_locations);
Graph_debiased = GraphOfX(debiased_city_locations);
Graph_biased = GraphOfX(biased_city_locations);
Graph_uniform_data_set = GraphOfX(uniform_data_set_city_locations);

%% Experiments_Debiased
beta = 30;
[Xhat_debiased,GraphHat_debiased] = RecoverySpherical(Graph_debiased,d,beta);
sum(sum(GraphHat_debiased~=Graph_debiased))
[Xhat_debiased,~,~] = RotateYtoX(debiased_city_locations,Xhat_debiased);
save("inferred_debiased_city_locations.txt","Xhat_debiased","-ascii");
%% Experiments_Biased
beta = 30;
[Xhat_biased,GraphHat_biased] = RecoverySpherical(Graph_biased,d,beta);
sum(sum(GraphHat_biased~=Graph_biased))
[Xhat_biased,~,~] = RotateYtoX(biased_city_locations,Xhat_biased);
save("inferred_biased_city_locations.txt","Xhat_biased","-ascii");
%% Experiments_Uniform_Data_Set
beta = 30;
[Xhat_uniform_data_set,GraphHat_uniform_data_set] = RecoverySpherical(Graph_uniform_data_set,d,beta);
sum(sum(GraphHat_uniform_data_set~=Graph_uniform_data_set))
[Xhat_uniform_data_set,~,~] = RotateYtoX(uniform_data_set_city_locations,Xhat_uniform_data_set);
save("inferred_uniform_data_set_city_locations.txt","Xhat_uniform_data_set","-ascii");

%%
function Graph = GraphOfX(X)
    inner_product = X'*X;
    Graph = 0.5*(sign(inner_product) + ones(size(inner_product)) - 4.*eye(size(inner_product,1)));
end
n = 100;
dimensions = [2,4,8,16,32,64];
iter = 20;

num_mismatched       = zeros(iter,size(dimensions,2));
distance_diffs       = zeros(iter,size(dimensions,2));
distance_standard_deviations = zeros(size(dimensions));

for dimidx = 1:size(dimensions,2)
    d = dimensions(dimidx);
    [tau,dist_std] = hyperbolic_threshold(d,10000,0.5);
    distance_standard_deviations(1,dimidx) = dist_std;
    if dimidx<= 4
        beta = 2/std_dists;
    else 
        beta = 5/std_dists;
    end
    for iteridx =1:iter
        M = hyperbolicfactory(d,n);
        u = M.rand();
        [Graph,Distances] = HyperbolicGraphDistances(u,tau);
        [Xhat, GraphHat,DistanceHat] = RecoveryHyperbolic(Graph,d,beta,tau);
        num_mismatched(iteridx,dimidx) = sum(sum(Graph~=GraphHat));
        distance_diffs(iteridx,dimidx) = norm(DistanceHat - Distances,"fro");
    end
end

%%uncomment to save results
save("tr_hyperbolic_graph_error.txt","num_mismatched","-ascii");
save("tr_hyperbolic_distances_error.txt","distance_diffs","-ascii");
save("tr_dist_standard_deviations.txt","distance_standard_deviations","-ascii");

fclose("all");

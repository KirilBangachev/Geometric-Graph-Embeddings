n = 100;
dimensions = [2,5,10,25,100]
iter = 20;
results_toric= zeros(iter,size(dimensions,2));

for iteridx=1:iter
    for dimidx = 1:size(dimensions,2)
        d = dimensions(dimidx);      
        [X, Graph,NoisyGraph] = GenerateToricData(n,d);
        [Xhat, GraphHat] = RecoveryToric(Graph,d, 5/sqrt(d));
        results_toric(iteridx,dimidx) = sum(sum(vecnorm(GraphHat - Graph,1))); 
    end
end
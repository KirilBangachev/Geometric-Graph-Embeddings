n = 100;
beta = 30;
dimensions = [2,5,10,25,50]
mask_rate = 0;
noise_rate = 0;
iter = 20;
results= zeros(iter,size(dimensions,2));

for iteridx=1:iter
    for dimidx = 1:size(dimensions,2)
        d = dimensions(dimidx);      
        [X, Graph,NoisyGraph] = GenerateData(n,d,noise_rate,mask_rate);
        [Xhat, GraphHat] = RecoverySpherical(NoisyGraph,d,beta);
        results(iteridx,dimidx) = sum(sum(vecnorm(GraphHat - Graph,1))); 
    end
end
%%
results
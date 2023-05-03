function [X, Graph,NoisyGraph] = GenerateData(n,d,noise_rate,mask_rate)
    arguments
        n double
        d double
        noise_rate double = 0;
        mask_rate double = 0;
    end
    X = normrnd(0,1,n,d);
    NormsX = vecnorm(X,2,2);
    X = X./NormsX;
    [Graph, NoisyGraph] = GraphOfX(X,noise_rate,mask_rate);
end

function [Graph,NoisyGraph] = GraphOfX(X,noise_rate,mask_rate)
    inner_product = X*X';
    Graph = 0.5*(sign(inner_product) + ones(size(inner_product)) - ...
        4.*eye(size(inner_product,1)));
    noise_matrix = binornd(1,noise_rate,size(inner_product));
    mask_matrix  = binornd(1,mask_rate,size(inner_product));
    NoisyGraph = -ones(size(inner_product));
    n = size(inner_product,1);
    for i=1:n
        for j = (i+1):n
            if mask_matrix(i,j)==1 %mask
                NoisyGraph(i,j) = -1;
                NoisyGraph(j,i) = -1;
            elseif noise_matrix(i,j) == 1 %Flip 
                NoisyGraph(i,j) = 1-Graph(i,j);
                NoisyGraph(j,i) = 1-Graph(i,j);
            else
                NoisyGraph(i,j) = Graph(i,j);
                NoisyGraph(j,i) = Graph(i,j);
            end
        end
    end
end
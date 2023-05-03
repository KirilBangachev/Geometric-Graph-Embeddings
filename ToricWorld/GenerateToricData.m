function [X, Graph,DistanceGraph] = GenerateToricData(n,d,tau)
    arguments
        n double
        d double
        tau double = pi*d/2;
    end
    X = normrnd(0,1,2,n*d);
    NormsX = vecnorm(X,2,1);
    X = X./NormsX;
    [Graph, DistanceGraph] = ToricGraphOfX(X,n,d,tau);
end
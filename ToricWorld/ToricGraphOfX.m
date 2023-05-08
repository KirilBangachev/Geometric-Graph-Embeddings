function [Graph,DistanceGraph] = ToricGraphOfX(X,n,d,tau)
    Graph = -ones(n,n);
    [~, DistanceGraph] = ToricDistances(X,n,d);
    for i = 1:n
        for j = (i+1):n
            if DistanceGraph(i,j)<tau
                Graph(i,j) = 1;
            else
                Graph(i,j) = 0;
            end
            Graph(j,i)=Graph(i,j); 
        end
    end
end
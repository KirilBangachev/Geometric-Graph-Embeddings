function [Graph,Distances]= HyperbolicGraphDistances(X,tau)
    d = size(X,1)-1;
    n = size(X,2);
    Graph = -ones(n);
    Distances = zeros(n);
    M = hyperbolicfactory(d,1);
    for i = 1:n
        for j = (i+1):n
            dist = M.dist(X(:,i),X(:,j));
            Distances(i,j) = dist;
            Distances(j,i) = dist;
            if dist<tau
                Graph(i,j) =  1;
                Graph(j,i) = 1;
            else
                Graph(i,j) = 0;
                Graph(j,i) = 0;
            end
        end
    end
end
function [CoordinateAlignments, L1Distances] = ToricDistances(X,n,d)
    L1Distances = zeros(n,n);
    CoordinateAlignments = zeros(d,n,n);
    for i = 1:n
        vec_i = X(:, (d*i - (d-1)):d*i);
        for j = (i+1):n
            vec_j = X(:, (d*j - (d-1)):d*j);
            for u = 1:d
                dotij = dot(vec_i(:,u),vec_j(:,u)); 
                if (dotij>1-eps) & (dotij<-1+eps) 
                    arccosij = pi
                    disp("oh no")
                else
                    arccosij = acos(dotij);
                end
                CoordinateAlignments(u,i,j) = dotij;
                CoordinateAlignments(u,j,i) = dotij;
                L1Distances(i,j)=  L1Distances(i,j)+arccosij;
            end
            L1Distances(j,i)  = L1Distances(i,j);  
        end
    end
end

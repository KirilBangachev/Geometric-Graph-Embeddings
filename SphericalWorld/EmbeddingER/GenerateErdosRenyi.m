function Graph = GenerateErdosRenyi(n,p)
    Graph = binornd(1,p,n,n);
    for i= 1:n
        Graph(i,i)=-1;
        for j=(i+1):n
            Graph(i,j) = Graph(j,i);
        end
    end
end
n = 100;
numd = 15;
dimensions = linspace(2,numd+1,numd);
iter = 10;
estimated_dimension = zeros(iter,numd);
for iteridx= 1:iter
    for dimidx = 1:numd
        dtrue = dimensions(dimidx);
        [X, Graph,NoisyGraph] = GenerateData(n,dtrue);
        [dfitted,FittedXHat,FittedGraph]= dimensionfitting(Graph,1/n);
        estimated_dimension(iteridx,dimidx) = dfitted;
        save("estimated_dimensions_low.txt","estimated_dimension","-ascii");
    end
end
estimated_dimension
save("estimated_dimensions_low.txt","estimated_dimension","-ascii");
fclose("all");

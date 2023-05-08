nvals = [10,25,40,55,70,85,100]
iter = 10;
d_estimated = zeros(iter,size(nvals,2));
for iteridx = 1:iter
    for nidx= 1:size(nvals,2)
        n = nvals(nidx)
        Graph =GenerateErdosRenyi(n,.5);
        [dfitted,FittedXHat,FittedGraph]= dimensionfitting(Graph);
        sum(sum(FittedGraph ~= Graph))
        d_estimated(iteridx,nidx) = dfitted;
    end
end

save("inferred_dimensions_er.txt","d_estimated","-ascii");


function [tau,std_dist] = hyperbolic_threshold(d,iter,p)
    arguments 
        d double
        iter double = 100000
        p double=.5
    end
    for i = 1:iter
        M =hyperbolicfactory(d,1);
        x= M.rand();
        y =M.rand();
        dists(1,i)= M.dist(x,y); 
    end
    dists = sort(dists);
    tau = dists(round(iter*p));
    std_dist = std(dists);
end
function [Xhat,GGX] = RecoverySpherical(G, d,beta,method)
    arguments 
        G (:,:) double 
        d double
        beta double = 5*sqrt(d);
        method string = "steepestdescent";
    end
    n = size(G,1);

    M = obliquefactory(d,n);
    problem.M = M;
    problem.cost = @mycost;
    problem.egrad = @myegrad;
    problem.ehess = @myehess;
    
    %figure; checkgradient(problem); pause;
    %figure; checkhessian(problem); pause;
    if method == "steepestdescent"
        Xhat = steepestdescent(problem);
    end

    if method == "trustregions"
        Xhat = trustregions(problem);
    end
    GGX = 0.5.*sign(Xhat'*Xhat)+0.5.*(ones(n,n)-4.*eye(n));

    function sigmax = sigma(myx)
        sigmax = 1/(1 + exp(-beta*myx));
    end

    function [cost, store] = mycost(Y, store)
        cost = 0;
        for i = 1:n
            for j = 1:n
                if G(i,j)>=0
                    sigma_val = sigma(dot(Y(:,i), Y(:,j))); 
                    cost = cost - G(i,j)*log(sigma_val) - (1-G(i,j))*log(1 - sigma_val);
                end
            end
        end
    end

    function [egrad, store] = myegrad(Y, store)
        egrad = zeros(size(Y));
        for i  = 1:n
            for j  = 1:n
                if G(i,j)>=0
                    sigma_val = sigma(dot(Y(:,i), Y(:,j)));
                    egrad(:,i) = egrad(:,i)-...
                        2.*(G(i,j)*beta*(1-sigma_val)-...
                        (1 - G(i,j))*beta*sigma_val).*Y(:,j);
                end
            end
        end
    end

    function [ehessv, store] = myehess(Y, V, store)
        ehessv = zeros(size(V));
        for i  = 1:n
            for j  = 1:n
                if G(i,j)>=0
                    sigma_val = sigma(dot(Y(:,i), Y(:,j)));
                    scalar_contribution = 2.*( ...
                    (beta^2)*sigma_val*(1-sigma_val)*(dot(Y(:,i), V(:,j)) + dot(Y(:,j), V(:,i)))).*Y(:,j);
                    vector_contribution = -2.*(G(i,j)*beta*(1-sigma_val)-(1 - G(i,j))*beta*sigma_val).*V(:,j);
                    ehessv(:,i) = ehessv(:,i) + scalar_contribution + vector_contribution;
                end
            end
        end
    end

end
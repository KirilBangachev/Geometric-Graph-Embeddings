function [Xhat, GraphHat,DistancesHat] = RecoveryHyperbolic(G,d,beta,tau,method)
    arguments 
        G (:,:) double 
        d double
        beta double 
        tau double = hyperbolic_threshold(d)
        method string = "trustregions";
    end
    
    n = size(G,1);
    minkowski_inverter = ones(d+1,1);
    minkowski_inverter(1,1)=-1;

    M = hyperbolicfactory(d,n);
    
    problem.M = M;
    problem.cost = @mycost;
    problem.egrad = @myegrad;
    problem.ehess = @myehess;
    
    %figure; checkgradient(problem); pause;
    %figure; checkhessian(problem); pause;

    if method == "steepestdescent"
        options.maxiter = 20000;
        [Xhat,~] = steepestdescent(problem,[],options);
    end

    if method == "trustregions"
        options.maxiter = 500;
        [Xhat,~] = trustregions(problem,[],options);
    end

    [GraphHat,DistancesHat] = HyperbolicGraphDistances(Xhat,tau);

    function sigmax = sigma(myx)
        sigmax = 1/(1 + exp(-beta*(tau-myx)));
    end

    function q = minkowski_norm(A)
        q = vecnorm(A,2)^2- 2*A(1)^2;
    end
    

    function [cost, store] = mycost(Y, store)
        cost = 0;
        [~, Distances] = HyperbolicGraphDistances(Y,tau);
        for i = 1:n
            for j = 1:n
                if G(i,j)>-1
                    sigma_val = sigma(Distances(i,j)); 
                    cost = cost - G(i,j)*log(sigma_val) - (1-G(i,j))*log(1 - sigma_val);
                end
            end
        end
    end

    function [egrad, store] = myegrad(Y, store)
        egrad = zeros(size(Y));
        [~, Distances] = HyperbolicGraphDistances(Y,tau);
        for i  = 1:n
            for j  = 1:n
                if G(i,j)>=0
                    sigma_val = sigma(Distances(i,j));
                    U = Y(:,i) - Y(:,j);
                    U_norm= max(0,minkowski_norm(U));
                    egrad(:,i)= egrad(:,i)+ 2*beta*(G(i,j)-sigma_val)/(...
                        sqrt(U_norm)*sqrt(1 +U_norm/4)).*(U.*minkowski_inverter);
                end
            end
        end
    end

    function [ehessv, store] = myehess(Y, V, store)
        ehessv = zeros(size(V));
        [~, Distances] = HyperbolicGraphDistances(Y,tau);
        for i  = 1:n
            for j  = 1:n
                if G(i,j)>=0
                    sigma_val = sigma(Distances(i,j));
                    U = Y(:,i) - Y(:,j);
                    UV = V(:,i) - V(:,j);
                    U_norm= max(0,minkowski_norm(U));
                    cross_terms= dot(U, UV.*minkowski_inverter);

                    % Sigma contribution
                    ehessv(:,i)= ehessv(:,i)+ 2*beta^2*sigma_val*(1-sigma_val)*cross_terms/(...
                        U_norm*(1 +U_norm/4)).*(U.*minkowski_inverter);

                    % U_norm first contribution 
                    ehessv(:,i)= ehessv(:,i)- 2*beta*(G(i,j)-sigma_val)*cross_terms/(...
                        sqrt(U_norm)^3*sqrt(1 +U_norm/4)).*(U.*minkowski_inverter);

                    % U_norm second contribution
                    ehessv(:,i)= ehessv(:,i)- 2*beta*(G(i,j)-sigma_val)*cross_terms/(...
                        4*sqrt(U_norm)*sqrt(1 +U_norm/4)^3).*(U.*minkowski_inverter);

                    % U contribution
                    ehessv(:,i)= ehessv(:,i)+ 2*beta*(G(i,j)-sigma_val)/(...
                        sqrt(U_norm)*sqrt(1 +U_norm/4)).*(UV.*minkowski_inverter);
                end
            end
        end
    end

end
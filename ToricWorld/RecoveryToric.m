function [Xhat,GraphHat,DistanceGraphHat] = RecoveryToric(G,d,beta,tau,method)
    arguments 
        G (:,:) double 
        d double
        beta double 
        tau double = pi*d/2;
        method string = "steepestdescent";
    end
    disp(beta)
    n = size(G,1);

    M = obliquefactory(2,n*d); % Each Point is represented as a product of d 2-spheres 
    
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
        %options.useRand = true;
        %Xhat = trustregions(problem,options);
        %size(Xhat)
        Xhat = trustregions(problem);
    end

    Xhat = realify(Xhat);

    [GraphHat,DistanceGraphHat] = ToricGraphOfX(Xhat,n,d,tau);

    function sigmax = sigma(myx)
        sigmax = 1/(1 + exp(-beta*(tau-myx)));
    end

    function realX = realify(X)
        X = real(X);
        NormsX = vecnorm(X,2,1);
        realX = X./NormsX;
    end


    function [cost, store] = mycost(Y, store)
        cost = 0;
        [~, L1Distances] = ToricDistances(Y,n,d);
        for i = 1:n
            for j = 1:n
                if G(i,j)>=0
                    sigma_val = sigma(L1Distances(i,j)); 
                    cost = cost - G(i,j)*log(sigma_val) - (1-G(i,j))*log(1 - sigma_val);
                end
            end
        end
    end

    function [egrad, store] = myegrad(Y, store)
        egrad = zeros(size(Y));
        Y = realify(Y);
        [CoordinateAlignments, L1Distances] = ToricDistances(Y,n,d);
        for i  = 1:n
            for j  = 1:n
                if G(i,j)>=0
                    sigma_val = sigma(L1Distances(i,j));
                    for u = 1:d 
                        dotij = CoordinateAlignments(u,i,j);
                        if (dotij>-1 + eps) & (dotij<1 - eps) %To avoid numerical issues
                            egrad(:,d*(i-1)+u) = egrad(:,d*(i-1)+u)-2.*( ...
                                G(i,j)*beta*(1-sigma_val)/sqrt(1 - dotij^2)-...
                                (1-G(i,j))*beta*sigma_val/sqrt(1 - dotij^2)).*Y(:,d*(j-1)+u);
                        end
                    end
                end
            end
        end
        egrad = real(egrad); %Numerical Issues
    end

    function [ehessv, store] = myehess(Y, V, store)
        ehessv = zeros(size(V));
        Y = realify(Y);
        [CoordinateAlignments, L1Distances] = ToricDistances(Y,n,d);
        for i  = 1:n
            for j  = 1:n
                if G(i,j)>=0
                    sigma_val = sigma(L1Distances(i,j));
                    crossterms = zeros(1,d);
                    sigmaargdiffterm = 0;
                    for u = 1:d
                        crossterms(1,u) =  (dot(Y(:,d*(i-1)+u),V(:,d*(j-1)+u))+dot(V(:,d*(i-1)+u),Y(:,d*(j-1)+u)));
                        dotij = CoordinateAlignments(u,i,j);
                        if (dotij>-1 + eps) & (dotij<1 - eps)
                            sigmaargdiffterm  = sigmaargdiffterm + crossterms(1,u)/(sqrt(1-dotij^2));
                        end
                    end

                    for u = 1:d 
                        dotij = CoordinateAlignments(u,i,j);

                        if (dotij>-1 + eps) & (dotij<1 - eps) %To avoid numerical issues

                            % Differentiating sigma part of Euclidean Grad
                            ehessv(:,d*(i-1)+u) = ehessv(:,d*(i-1)+u)+ Y(:,d*(j-1)+u).*...
                            (2*beta*beta*sigma_val*(1-sigma_val)*sigmaargdiffterm/sqrt(1 - dotij^2));

                            % Differentiating sqrt(1- dotij^2) part
                       
                            ehessv(:,d*(i-1)+u) = ehessv(:,d*(i-1)+u)-2*crossterms(1,u)*dotij*( ...
                                G(i,j)*beta*(1-sigma_val)/(sqrt(1 - dotij^2)^3)-...
                                (1-G(i,j))*beta*sigma_val/(sqrt(1 - dotij^2)^3)).*Y(:,d*(j-1)+u);

                            % Differentiate V part of Euclidean Grad
                            ehessv(:,d*(i-1)+u) = ehessv(:,d*(i-1)+u)-2.*( ...
                                G(i,j)*beta*(1-sigma_val)/sqrt(1 - dotij^2)-...
                                (1-G(i,j))*beta*sigma_val/sqrt(1 - dotij^2)).*V(:,d*(j-1)+u);
                        end
                    end
                end
            end
        end
        ehessv=real(ehessv);
    end
end
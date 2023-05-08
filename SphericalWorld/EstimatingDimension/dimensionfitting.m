function [dfitted,FittedXHat,FittedGraph] = dimensionfitting(G,tolerance,num_trials,beta,method)
    arguments
        G (:,:) double 
        tolerance double = eps;
        num_trials=3;
        beta double = 30;
        method string = "steepestdescent";
    end

    dcurrent =2;
    dlow = 2;
    dhigh = 2;
    n = size(G,1);
    min_error= 1;
    
    while 1>0
        error_this_round = 1;
        for trial= 1:num_trials
            [XHat, GraphHat] = RecoverySpherical(G,dcurrent,beta);
            error = sum(vecnorm(G-GraphHat,1))/(n*(n-1));
            if error<min_error
                FittedGraph = GraphHat;
                FittedXHat= XHat;
                min_error= error;
            end
            if error<error_this_round
                error_this_round = error;
            end
            if error==0
                break;
            end
        end
        
        if error_this_round > tolerance
            if dhigh== dcurrent
                dhigh = 2*dcurrent;
                dcurrent = 2*dcurrent;
            end
            if dhigh == dcurrent + 1
                break
            end
            if dhigh >=dcurrent + 2
                dlow = dcurrent;
                dcurrent = round((dhigh+dlow)/2);
            end
        end

        if error_this_round <= tolerance
            dfitted= dcurrent;
            if dlow+1>=dcurrent
                break
            else
                dhigh= dcurrent;
                dcurrent = round((dhigh+ dlow)/2);
            end
        end
    end
end


n = 100;
d=10;
noise_rate = 0.00;
mask_rates = linspace(0,3,10)./10;
iter = 10;
results_inferred_to_true = zeros(iter,size(mask_rates,2));
results_inferred_to_true_on_revealed = zeros(iter,size(mask_rates,2));
results_num_hidden = zeros(iter,size(mask_rates,2));

for iteridx=1:iter
    for maskidx = 1:size(mask_rates,2)
        mask_rate = mask_rates(maskidx);
        beta = 30;
        [X, Graph,NoisyGraph] = GenerateData(n,d,noise_rate,mask_rate);
        [Xhat, GraphHat] = RecoverySpherical(NoisyGraph,d,beta);
        [inferred_to_true, inferred_to_true_on_revealed, num_hidden] = distance(Graph, NoisyGraph,GraphHat);
        results_num_hidden(iteridx, maskidx) = num_hidden/nchoosek(n,2);
        results_inferred_to_true(iteridx, maskidx) = inferred_to_true/nchoosek(n,2);
        results_inferred_to_true_on_revealed(iteridx, maskidx) = inferred_to_true_on_revealed/nchoosek(n,2);
    end
end

%% function
function [inferred_to_true, inferred_to_true_on_revealed, num_hidden] = distance(Graph, NoisyGraph,GraphHat)
    inferred_to_true = 0; inferred_to_true_on_revealed = 0;num_hidden = 0;
    m = size(Graph,1);
    for i = 1:m
        for j = (i+1):m
            if NoisyGraph(i,j) == -1
                num_hidden= num_hidden +1;
            end

            if Graph(i,j)~=GraphHat(i,j)
                   inferred_to_true =inferred_to_true +1; 
            end

            if (Graph(i,j)~=GraphHat(i,j)) & (NoisyGraph(i,j) ~= -1)
                   inferred_to_true_on_revealed =inferred_to_true_on_revealed +1; 
            end

        end
    end
end
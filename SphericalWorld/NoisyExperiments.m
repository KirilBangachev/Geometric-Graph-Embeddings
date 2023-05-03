n = 100;
d=10;
beta = 30;
noise_rates = linspace(0.0,0.001,20);
mask_rate = 0;
iter = 10;
results_noise_to_true= zeros(iter,size(noise_rates,2));
results_noise_to_hat = zeros(iter,size(noise_rates,2));
results_true_to_hat = zeros(iter,size(noise_rates,2));
results_true_to_hat_uncorrupted = zeros(iter,size(noise_rates,2));
results_corrected_bad = zeros(iter,size(noise_rates,2));
results_corrected_good = zeros(iter,size(noise_rates,2));

for iteridx=1:iter
    for noiseidx = 1:size(noise_rates,2)
        noise_rate = noise_rates(noiseidx);      
        [X, Graph,NoisyGraph] = GenerateData(n,d,noise_rate,mask_rate);
        [Xhat, GraphHat] = RecoverySpherical(NoisyGraph,d,beta);
        [noise_to_true,noise_to_hat,true_to_hat,true_to_hat_uncorrupted,...
        corrected_good, corrected_bad] = noisydistance(Graph, NoisyGraph,GraphHat);
        results_noise_to_true(iteridx,noiseidx) = noise_to_true/nchoosek(n,2);
        results_noise_to_hat(iteridx,noiseidx) = noise_to_hat/nchoosek(n,2);
        results_true_to_hat(iteridx,noiseidx) = true_to_hat/nchoosek(n,2);
        results_true_to_hat_uncorrupted(iteridx,noiseidx) = true_to_hat_uncorrupted/nchoosek(n,2);
        results_corrected_good(iteridx,noiseidx) = corrected_good/noise_to_true;
        results_corrected_bad(iteridx,noiseidx) = corrected_bad/noise_to_true;
    end
end

%% function
function [noise_to_true,noise_to_hat,true_to_hat,true_to_hat_uncorrupted,...
    corrected_good,corrected_bad] = noisydistance(Graph, NoisyGraph,GraphHat)
    noise_to_true = sum(sum(Graph ~= NoisyGraph));
    noise_to_hat  = sum(sum(GraphHat ~= NoisyGraph));
    true_to_hat   = sum(sum(GraphHat ~= Graph));
    true_to_hat_uncorrupted  = sum(sum((GraphHat ~= Graph) & (GraphHat == NoisyGraph)));
    corrected_good = sum(sum((GraphHat ~= NoisyGraph) & (GraphHat == Graph)));
    corrected_bad =  sum(sum((GraphHat == NoisyGraph) & (GraphHat ~= Graph)));
end

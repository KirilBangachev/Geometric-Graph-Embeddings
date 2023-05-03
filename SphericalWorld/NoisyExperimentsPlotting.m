average_noise_to_true = mean(results_noise_to_true,1);
average_noise_to_hat = mean(results_noise_to_hat,1);
average_true_to_hat = mean(results_true_to_hat,1);
average_true_to_hat_uncorrupted = mean(results_true_to_hat_uncorrupted,1);
average_corrected_good = mean(results_corrected_good,1);
average_corrected_bad = mean(results_corrected_bad,1);

noisetotrue = plot(noise_rates,average_noise_to_true,color = "red")
hold on;
noisetohat = plot(noise_rates,average_noise_to_hat,color = "black")
hold on;
truetohat = plot(noise_rates,average_true_to_hat,color = "green")
hold on;
truetohatuncorrupted = plot(noise_rates,average_true_to_hat_uncorrupted,color = "blue")

xlabel("Noise Rate",'FontSize', 22)
ylabel("Fraction of Edges",'FontSize', 22)
hold on;
legend([noisetotrue,noisetohat,truetohat,truetohatuncorrupted], ...
    ["Noise and True", "Noise and Inferred", "True and Inferred", "True and Inferred, Uncorrupted"],'FontSize', 22)
%%
corgood = plot(noise_rates,average_corrected_good,color = "cyan")
hold on;
corbad = plot(noise_rates,average_corrected_bad,color = "magenta")
hold on;

xlabel("Noise Rate",'FontSize', 22)
ylabel("Fraction of Corrupted Edges",'FontSize', 22)
hold on;
legend([corgood,corbad],["Corrected Corrupted Edges", "Spoiled Uncorrupted Edges"],'FontSize', 22)
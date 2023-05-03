average_to_true = mean(results_inferred_to_true,1);
average_on_revealed = mean(results_inferred_to_true_on_revealed,1);
average_num_hidden = mean(results_num_hidden,1);

%avgtotrue = plot(mask_rates,average_to_true,color = "red")
hold on;
avgrvld = plot(mask_rates,average_on_revealed,color = "blue")
xlabel("Mask Rate",'FontSize', 22)
ylabel("Fraction of Edges",'FontSize', 22)
hold on;
%avgmasked = plot(mask_rates,average_num_hidden,color = "black")
legend([avgrvld], ["Incorrectly Embedded Revealed Edges"],'FontSize', 22)
plt.YAxis.FontSize = 22;
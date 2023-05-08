average_low = mean(results_distances(:,1:9),1);
average_high = mean(results_distances(:,10:18),1);

plot(dimensions(1:9),average_low)
xlabel("Dimension p")
ylabel("Relative Error of Estimated Distances")
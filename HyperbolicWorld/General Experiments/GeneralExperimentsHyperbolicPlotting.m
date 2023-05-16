%plotting mismatched edges
for i = 1:6
    subplot(2,3,i)
    hist(num_mismatched(:,i)./2)
    xlabel("p = "+dimensions(i),"FontSize", 22)
end

%% plotting relative distance matrices
squared_dist_diffs = distance_diffs.^2;
expected_distance_diffs = n*(n-1).*(distance_standard_deviations.^2);
normalized = squared_dist_diffs./expected_distance_diffs;



for i = 1:6
    subplot(2,3,i)
    hist(normalized(:,i))
    xlabel("p = "+dimensions(i),"FontSize", 22)
end
%%
averaged_mean = mean(normalized,1);
plot([2,3,4,5,6],log(averaged_mean(1,2:6)))
xlabel("log(p)")
ylabel("Log - Average Relative Difference of Distance Matrices")


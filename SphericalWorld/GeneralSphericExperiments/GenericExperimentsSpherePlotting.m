%avgtotrue = plot(mask_rates,average_to_true,color = "red")
for i = 1:8
    subplot(3,3,i)
    hist(results(:,i)./2)
    xlabel("p = "+dimensions(i),"FontSize", 22)
end

%%
subplot(3,3,1)
hist(distance_to_opt_rotation(:,1))
xlabel("p = "+dimensions(1),"FontSize", 22)

without_outlier = distance_to_opt_rotation(:,1)<0.3
subplot(3,3,2)
hist(distance_to_opt_rotation(without_outlier,1))
xlabel("p = 2 without outlier","FontSize", 22)

for i = 2:8
    subplot(3,3,i+1)
    hist(distance_to_opt_rotation(:,i))
    xlabel("p = "+dimensions(i),"FontSize", 22)
end



%avgtotrue = plot(mask_rates,average_to_true,color = "red")
numd= 9
dimensions = linspace(2,numd+1,numd);
for i=1:9
    subplot(3,3,i)
    hist(estimated_dimension(:,i))
    xlabel("p = "+dimensions(i),"FontSize", 22)
end

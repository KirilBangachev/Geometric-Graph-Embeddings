dimensions = [2,4,8,16,32,64];
results_toric = importdata("toric_general.txt");
fclose("all")
for i = 1:6
    subplot(2,3,i)
    hist(results_toric(:,i)./2)
    xlabel("p = "+dimensions(i),"FontSize", 22)
end
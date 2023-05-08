nvals = [10,25,40,55,70,85,100]
for i=1:7
    subplot(3,3,i)
    hist(d_estimated(:,i))
    xlabel("n = "+nvals(i),"FontSize", 22)
end
%%
avg_fitted = mean(d_estimated,1);
plot(nvals,avg_fitted)
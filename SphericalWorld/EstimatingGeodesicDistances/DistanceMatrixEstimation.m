n = 100;
dimensions = [2,3,4,5,6,7,8,9,10,20,30,40,50,60,70,80,90,100];
mask_rate = 0;
noise_rate = 0;
iter = 20;
results_distances= zeros(iter,size(dimensions,2));
%%
for dimidx = 1:size(dimensions,2)
    d = dimensions(dimidx);
    std_geodesic_distance = find_std_distance(d); 
    for iteridx =1:iter
        [X, Graph,NoisyGraph] = GenerateData(n,d,noise_rate,mask_rate);
        [Xhat, GraphHat] = RecoverySpherical(NoisyGraph,d);
        results_distances(iteridx,dimidx) = find_relative_difference_of_distances(X,Xhat,std_geodesic_distance); 
    end
end
results_distances
save("distance_matrix.txt","results_distances","-ascii");
fclose("all")


function relative_difference_of_distances = find_relative_difference_of_distances(X, XHat,std)
   n = size(X,1);
   true_distances = find_distances_from_locations(X);
   inferred_distances = find_distances_from_locations(XHat');
   relative_difference_of_distances = ...
       norm(true_distances - inferred_distances,"fro")/(std*sqrt(n*(n-1)));% Normalizing by std
end

function distances = find_distances_from_locations(Y)
    n =size(Y,1);
    distances = zeros(n);
    for i = 1:n
        for j = 1:n
            distances(i,j) = acos(dot(Y(i,:),Y(j,:)));
        end
    end
end
%%

function std_distance = find_std_distance(d)
    trials = 100000;
    first_vec = normrnd(0,1,d,trials);
    first_vec = first_vec./vecnorm(first_vec,2);
    second_vec = normrnd(0,1,d,trials);
    second_vec = second_vec./vecnorm(second_vec,2);
    distances = zeros(1,trials);
    for idx = 1:trials
        distances(1,idx)= acos(dot(first_vec(:,idx),second_vec(:,idx)));
    end
    std_distance = std(distances);
end
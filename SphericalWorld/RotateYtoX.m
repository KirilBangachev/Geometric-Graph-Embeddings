function [Image,TotalL2Distance,ElementWiseL2Distance] = RotateYtoX(X,Y)
    prod = X*Y';
    [U,S,V] = svd(prod);
    Image = U*V'*Y;
    TotalL2Distance = norm(X - Image, "fro");
    ElementWiseL2Distance = vecnorm(X - Image,2);
    size(ElementWiseL2Distance)
end

locations_320 = importdata("City Data/inferred_city_locations_320.txt");
locations_true = importdata("city_loactions");

locations_320_rotated = RotateYtoX(locations_true(1:320,:)', locations_320)
save("City Data/rotated_city_locations_320.txt", "locations_320_rotated","-ascii")


Folder with optimization implementations and experiments for embeddings in $T^{p}$ with Manhattan distance. Contains:
- RecoevryToric.m which is the main embedding algorithm. 
- ToricGraphOfX.m which generates the adjacency matrix for a Toric Manhattan geometric graph on input locations on teh torus and distance tau.
- ToricDistances.m which computes the manhattan distance between two points on teh torus.
- GenerateToricData.m, which generates a toric RGG.

Experiments include:
- GeneralToricExperiments Folder, which contains an experiment that estimates what fraction of the edges are correctly embedded for different dimensions.


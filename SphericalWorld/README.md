Folder with optimization implementations and experiments for embeddings in $S^{p-1}$ with a $L_2$ distance. Contains:
- RecoverySpherical.m which is the main algorithm. It embeds an adjacency matrix G in S^{p-1} via steepestdescent/trustregions. 
- GenerateData.m which is a script for generating a spherical RGG.
- RotateYtoX which is a script that returns $OY$ on input $X,Y,$ where $O$ is the orthogonalmatrix minimzing $\|X - OY\|_F$ It is given by $UV^T,$ where $U\Sigma V^T$ is the SVD decomposition of $XY^T.$  

Folders with experiments:
- CityExperiment Folder, containing an experimentwith 320 randomly sampled cities around teh globe. Different distributions are tested.
- EmbeddingER Folder, containing an experiment which embeds a sample of $G(n,1/2)$ as spherical RGG.
- EstimatingDimension Folder, containing a script that estimates the dimension of an RGG by binary searching for teh minimal dimension in which it can be embedded.
- EstimatingGeodesicDistances Folder, containing an experiment for estimating geodesic distances from adjacency matrix of graph.
- MaksedGraphsEmbedding Folder, containing an experiment for embedding with masked data.
- NoisyGraphsEmbedding Folder, containing an experiment for embedding with noisy data.

# Geometric-Graph-Embeddings
Optimization Approach To Geometric Graph Embedding

Final Project For 6.8410@MIT, Spring 2023,
Kiril Bangachev,
Instructor: Justin Solomon,
TA: Theia Henderson

A geometric graph is defined by a manifold $\mathcal{M},$ threshold $\tau,$ distance function $d:\mathcal{M}\times\mathcal{M}\longrightarrow \mathbb{R}_{\ge 0},$ and $n$ points $\mathbf{x}^1, \mathbf{x}^2, \ldots, \mathbf{x}^n$ on $\mathcal{M}.$ Then, 
$\mathbf{gg}(\mathbf{x}^1, \mathbf{x}^2, \ldots, \mathbf{x}^n)$ is a graph on vertex set $[n] = \{1,2,\ldots, n\},$ where vertices $i$ and $j$ are connected if and only if $d(\\mathbf{x}^i, \mathbf{x}^j)\le \tau.$ In the problem of embedding a geometric graph, one is given $\mathcal{M},\tau,d$ and an adjacency matrix $\mathbf{G}.$ The goal is to find $n$ points $\mathbf{y}^1, \mathbf{y}^2, \ldots, \mathbf{y}^n$ on $\mathcal{M}$ such that $\mathbf{gg}(\mathbf{y}^1, \mathbf{y}^2, \ldots, \mathbf{y}^n)$ has adjacency matrix $\mathbf{G}.$

We propose a solution by formulating a corresponding minimzation problem over the product manifold $\mathcal{M}^{\times n}$ and running first- and second-order (Riemannian) optimization algorithms. Our approach improves on previous work in two different ways. 
1) Generalizability.
First-order optimization already achieves meaningful embeddings for a variety of different manifolds and distance functions, 
including spherical manifolds with the induced $L_2$ metric, 
hyperbolic space with the Minkowski metric,
and 
tori with the Manhattan metric.
Most previous work is restricted to $L_2$-distances in Euclidean space. 
2) Robustness.
The optimization approach performs extremely well when as much as a constant fraction of the graph edges are hidden. Again, this seems out of reach for most previous algorithms.

Our approach has applications to estimating the dimension of geometric graphs, estimating geodesic distances between latent vectors, recovering missing edges in geometric graphs, and reducing the amount of noise in geometric graphs.

Our code is based on the manopt library. https://www.manopt.org/index.html

In this repository:
- paper.pdf explaining our methods (to be added very soon).
- SphericalWorld folder with implementtaion for the $L_2$ spherical geometric graphs.
- ToricWorld folder with implementtaion for the Manhattain toric geometric graphs.
- HyperbolicWorld folder with implementtaion for the Minkowski hyperbolic geometric graphs.

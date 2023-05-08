# Geometric-Graph-Embeddings
Optimization Approach To Geometric Graph Embedding

Final Project For 6.8410@MIT, Spring 2023,
Kiril Bangachev,
Instructor: Justin Solomon,
TA: Theia Henderson

A geometric graph is defined by a manifold $\mathcal{M},$ threshold $\tau,$ distance function $d:\mathcal{M}\times\mathcal{M}\longrightarrow \mathbb{R}_{\ge 0},$ and $n$ points $\mathbf{x}^1, \mathbf{x}^2, \ldots, \mathbf{x}^n$ on $\mathcal{M}.$ Then, 
$\mathbf{gg}(\mathbf{x}^1, \mathbf{x}^2, \ldots, \mathbf{x}^n)$ is a graph on vertex set $[n] = \{1,2,\ldots, n\},$ where vertices $i$ and $j$ are connected if and only if $d(\\mathbf{x}^i, \mathbf{x}^j)\le \tau.$ In the problem of embedding a geometric graph, one is given $\mathcal{M},\tau,d$ and an adjacency matrix $\mathbf{G}.$ The goal is to find $n$ points $\mathbf{y}^1, \mathbf{y}^2, \ldots, \mathbf{y}^n$ on $\mathcal{M}$ such that $\mathbf{gg}(\mathbf{y}^1, \mathbf{y}^2, \ldots, \mathbf{y}^n)$ has adjacency matrix $\mathbf{G}.$

We propose an empirical solution by formulating a corresponding minimzation problem over the product manifold $\mathcal{M}^{\times n}$ and running first- and second-order (Riemannian) optimization algorithms. Admittedly, our method lacks the rigour of certain other geometric graph embedding techniques in the literature such as spectral methods and combinatorial embeddings. Nevertheless, our approach improves on previous methods in two ways. First, it yields meaningful embeddings even if a constant fraction of the matrix $\mathbf{G}$ is hidden. This seems completely out of reach for the spectral approaches. Second, it can be applied to any pair $(\mathcal{M},d(\cdot,\cdot)),$ unlike spectral and combinatorial approaches, which heavily depend on the underlying $L_2$-geometry of $\mathcal{M}$ and $d(\cdot,\cdot).$ We demonstrate this by running experiments using the Manhattan distance on Tori.

Our code is based on the manopt library.

In this repository:
- paper.pdf explaining our methods (to be added very soon).
- SphericalWorld folder with implementtaion for the $L_2$ spherical geometric graphs.
- ToricWorld folder with implementtaion for the Manhattain toric geometric graphs.

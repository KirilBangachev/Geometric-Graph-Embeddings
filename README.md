# Geometric-Graph-Embeddings
Optimization Approach To Geometric Graph Embedding
Final Project For 6.8410@MIT, Spring 2023,
Kiril Bangachev
Instructor: Justin Solomon
TA: Theia Henderson

A geometric graph is defined by a manifold $\manifold,$ threshold $\tau,$ distance function $d:\manifold\times\manifold\longrightarrow \mathbb{R}_{\ge 0},$ and $n$ points $\bfx^1, \bfx^2, \ldots, \bfx^n$ on $\mathcal{M}.$ Then, 
$\geometricgraph(\bfx^1, \bfx^2, \ldots, \bfx^n)$ is a graph on vertex set $[n] = \{1,2,\ldots, n\},$ where vertices $i$ and $j$ are connected if and only if $d(\bfx^i, \bfx^j)\le \tau.$ In the problem of embedding a geometric graph, one is given $\mathcal{M},\tau,d$ and an adjacency matrix $\bfG.$ The goal is to find $n$ points $\bfy^1, \bfy^2, \ldots, \bfy^n$ on $\manifold$ such that $\geometricgraph(\bfy^1, \bfy^2, \ldots, \bfy^n)$ has adjacency matrix $\bfG$ \cite{Dani22,OConner20}.

We propose an empirical solution by formulating a corresponding minimzation problem over the product manifold $\mathcal{M}^{\times n}$ and running first- and second-order (Riemannian) optimization algorithms. Admittedly, our method lacks the rigour of certain other geometric graph embedding techniques in the literature such as spectral methods \cite{OConner20} and combinatorial embeddings \cite{Dani22}. Nevertheless, our approach improves on previous methods in two ways. First, it yields meaningful embeddings even if a constant fraction of the matrix $\bfG$ is hidden. This seems completely out of reach for the spectral approaches. Second, it can be applied to any pair $(\manifold,d(\cdot,\cdot)),$ unlike spectral and combinatorial approaches, which heavily depend on the underlying $L_2$-geometry of $\manifold$ and $d(\cdot,\cdot).$ We demonstrate this by 
    running experiments using the Manhattan distance on Tori.

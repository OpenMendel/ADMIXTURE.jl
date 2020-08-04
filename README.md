# ADMIXTURE.jl

| **Documentation** | **Build Status** | **Code Coverage**  |
|-------------------|------------------|--------------------|
| [![](https://img.shields.io/badge/docs-stable-blue.svg)](https://github.com/OpenMendel/ADMIXTURE.jl/stable) [![](https://img.shields.io/badge/docs-dev-blue.svg)](https://github.com/OpenMendel/ADMIXTURE.jl/dev) | [![Build Status](https://travis-ci.com/OpenMendel/WiSER.jl.svg?branch=master)](https://travis-ci.com/OpenMendel/ADMIXTURE.jl)  | [![Coverage Status](https://coveralls.io/repos/github/OpenMendel/ADMIXTURE.jl/badge.svg?branch=master)](https://coveralls.io/github/OpenMendel/ADMIXTURE.jl?branch=master) [![codecov](https://codecov.io/gh/OpenMendel/ADMIXTURE.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/OpenMendel/ADMIXTURE.jl) |  


ADMIXTURE.jl is a Julia wrapper of the popular [ADMIXTURE program](http://dalexander.github.io/admixture/) for estimating ancestry in a model-based manner from large autosomal SNP genotype data sets. 

The method is described in the paper:   
> D Alexander, J Novembre, and K Lange. (2009) Fast model-based estimation of ancestry in unrelated individuals, _Genome Research_, 19(9):1655–1664. <https://dx.doi.org/10.1101/gr.094052.109>

ADMIXTURE.jl requires Julia v1.3 or later. See documentation for usage. It is not yet registered and can be installed, in the Julia Pkg mode, by
```{julia}
(@v1.5) Pkg> add https://github.com/OpenMendel/ADMIXTURE.jl
```

As a quick example, suppose a set of PLINK files `hapmap3.bed`, `hapmap3.bim`, `hapmap3.fam` are available in the current directory, then
```julia
P, Q = admixture("hapmap3.bed", 3)
```
returns the `P` matrix (allele frequencies of the inferred ancestral populations) and the `Q` matrix (the ancestry fractions). The output files by ADMIXTURE will be saved in the same directory of the input files. 

For more details, check the documentation. 

# ADMIXTURE.jl

| **Documentation** | **Build Status** | **Code Coverage**  |
|-------------------|------------------|--------------------|
| [![](https://img.shields.io/badge/docs-stable-blue.svg)](https://openmendel.github.io/ADMIXTURE.jl/stable) [![](https://img.shields.io/badge/docs-dev-blue.svg)](https://openmendel.github.io/ADMIXTURE.jl/dev/) | [![Build Status](https://travis-ci.org/OpenMendel/ADMIXTURE.jl.svg?branch=master)](https://travis-ci.org/github/OpenMendel/ADMIXTURE.jl)  | [![Coverage Status](https://coveralls.io/repos/github/OpenMendel/ADMIXTURE.jl/badge.svg?branch=master)](https://coveralls.io/github/OpenMendel/ADMIXTURE.jl?branch=master) [![codecov](https://codecov.io/gh/OpenMendel/ADMIXTURE.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/OpenMendel/ADMIXTURE.jl) |  


ADMIXTURE.jl is a Julia wrapper of the popular [ADMIXTURE program](http://dalexander.github.io/admixture/) for estimating ancestry in a model-based manner from large autosomal SNP genotype data sets. 

The methodology is described in following papers:  

1. D Alexander, J Novembre, and K Lange. (2009) Fast model-based estimation of ancestry in unrelated individuals, _Genome Research_, 19(9):1655–1664. <https://dx.doi.org/10.1101/gr.094052.109>  

2. D Alexander and K Lange. (2011) Enhancements to the ADMIXTURE algorithm for individual
ancestry estimation. _BMC Bioinformatics_, 12:246. <https://doi.org/10.1186/1471-2105-12-246>  

3. S Shringarpure, C Bustamante, K Lange, and D Alexander. (2016) Efficient analysis of large datasets and sex bias with ADMIXTURE. _BMC Bioinformatics_ 17:218. <https://doi.org/10.1186/s12859-016-1082-x>

ADMIXTURE.jl requires Julia v1.3 or later. See documentation for usage. It is not yet registered and can be installed, in the Julia Pkg mode, by
```{julia}
(@v1.5) Pkg> add https://github.com/OpenMendel/ADMIXTURE.jl
```
The original ADMIXTURE software thus ADMIXTURE.jl only support Linux and MacOS.

As a quick example, suppose a set of PLINK files `hapmap3.bed`, `hapmap3.bim`, `hapmap3.fam` are available in the current directory. Then
```julia
P, Q = admixture("hapmap3.bed", 3)
```
returns the `P` matrix (allele frequencies of the inferred ancestral populations) and the `Q` matrix (the ancestry fractions). The output files by ADMIXTURE are saved in the working directory. 

For more details, check the documentation. 

# ADMIXTURE.jl

ADMIXTURE.jl is a Julia wrapper of the popular [ADMIXTURE program](http://dalexander.github.io/admixture/) for estimating ancestry in a model-based manner from large autosomal SNP genotype data sets.

## Installation

ADMIXTURE.jl requires Julia v1.3 or later. See documentation for usage. It is not yet registered and can be installed, in the Julia Pkg mode, by
```{julia}
(@v1.5) Pkg> add https://github.com/OpenMendel/ADMIXTURE.jl
```
The original ADMIXTURE software thus ADMIXTURE.jl only support Linux and MacOS.


```julia
versioninfo()
```

    Julia Version 1.5.0
    Commit 96786e22cc (2020-08-01 23:44 UTC)
    Platform Info:
      OS: macOS (x86_64-apple-darwin18.7.0)
      CPU: Intel(R) Core(TM) i7-6920HQ CPU @ 2.90GHz
      WORD_SIZE: 64
      LIBM: libopenlibm
      LLVM: libLLVM-9.0.1 (ORCJIT, skylake)
    Environment:
      JULIA_EDITOR = code
      JULIA_NUM_THREADS = 4



```julia
# for use in this tutorial
using ADMIXTURE, Glob, Tar
```

## Quick example

ADMIXTURE.jl only exports one function `admixture`. The usage resembles the original ADMIXTURE software. 

Let's first download a sample data set (in PLINK binary format) to the `/hapmap3` folder.


```julia
isfile("hapmap3.tar") || 
download("http://dalexander.github.io/admixture/hapmap3-files.tar.gz", 
         joinpath(pwd(), "hapmap3.tar"))
isdir("hapmap3") ||
Tar.extract("hapmap3.tar", joinpath(pwd(), "hapmap3"))
readdir(glob"hapmap3/hapmap3.*")
```




    4-element Array{String,1}:
     "hapmap3/hapmap3.bed"
     "hapmap3/hapmap3.bim"
     "hapmap3/hapmap3.fam"
     "hapmap3/hapmap3.map"



To estimate ancestry from $K=3$ populations, simply run


```julia
P, Q = admixture("hapmap3/hapmap3.bed", 3);
```

    ****                   ADMIXTURE Version 1.3.0                  ****
    ****                    Copyright 2008-2015                     ****
    ****           David Alexander, Suyash Shringarpure,            ****
    ****                John  Novembre, Ken Lange                   ****
    ****                                                            ****
    ****                 Please cite our paper!                     ****
    ****   Information at www.genetics.ucla.edu/software/admixture  ****
    
    Random seed: 43
    Point estimation method: Block relaxation algorithm
    Convergence acceleration algorithm: QuasiNewton, 3 secant conditions
    Point estimation will terminate when objective function delta < 0.0001
    Estimation of standard errors disabled; will compute point estimates only.


    ┌ Info: ADMIXTURE command:
    │ `/Users/huazhou/.julia/artifacts/7d0732a6f20d0cf8c106525a4602fc824e4cff31/dist/admixture_macosx-1.3.0/admixture /Users/huazhou/.julia/dev/ADMIXTURE/docs/hapmap3/hapmap3.bed 3`
    └ @ ADMIXTURE /Users/huazhou/.julia/dev/ADMIXTURE/src/ADMIXTURE.jl:57
    ┌ Info: Output directory: /Users/huazhou/.julia/dev/ADMIXTURE/docs
    └ @ ADMIXTURE /Users/huazhou/.julia/dev/ADMIXTURE/src/ADMIXTURE.jl:58


    Size of G: 324x13928
    Performing five EM steps to prime main algorithm
    1 (EM) 	Elapsed: 0.334	Loglikelihood: -4.38757e+06	(delta): 2.87325e+06
    2 (EM) 	Elapsed: 0.358	Loglikelihood: -4.25681e+06	(delta): 130762
    3 (EM) 	Elapsed: 0.375	Loglikelihood: -4.21622e+06	(delta): 40582.9
    4 (EM) 	Elapsed: 0.363	Loglikelihood: -4.19347e+06	(delta): 22748.2
    5 (EM) 	Elapsed: 0.333	Loglikelihood: -4.17881e+06	(delta): 14663.1
    Initial loglikelihood: -4.17881e+06
    Starting main algorithm
    1 (QN/Block) 	Elapsed: 0.711	Loglikelihood: -3.94775e+06	(delta): 231058
    2 (QN/Block) 	Elapsed: 0.712	Loglikelihood: -3.8802e+06	(delta): 67554.6
    3 (QN/Block) 	Elapsed: 0.667	Loglikelihood: -3.83232e+06	(delta): 47883.8
    4 (QN/Block) 	Elapsed: 0.94	Loglikelihood: -3.81118e+06	(delta): 21138.2
    5 (QN/Block) 	Elapsed: 0.816	Loglikelihood: -3.80682e+06	(delta): 4354.36
    6 (QN/Block) 	Elapsed: 0.811	Loglikelihood: -3.80474e+06	(delta): 2085.65
    7 (QN/Block) 	Elapsed: 0.79	Loglikelihood: -3.80362e+06	(delta): 1112.58
    8 (QN/Block) 	Elapsed: 0.857	Loglikelihood: -3.80276e+06	(delta): 865.01
    9 (QN/Block) 	Elapsed: 0.819	Loglikelihood: -3.80209e+06	(delta): 666.662
    10 (QN/Block) 	Elapsed: 0.958	Loglikelihood: -3.80151e+06	(delta): 579.49
    11 (QN/Block) 	Elapsed: 0.808	Loglikelihood: -3.80097e+06	(delta): 548.156
    12 (QN/Block) 	Elapsed: 0.872	Loglikelihood: -3.80049e+06	(delta): 473.565
    13 (QN/Block) 	Elapsed: 0.778	Loglikelihood: -3.80023e+06	(delta): 258.61
    14 (QN/Block) 	Elapsed: 0.883	Loglikelihood: -3.80005e+06	(delta): 179.949
    15 (QN/Block) 	Elapsed: 0.915	Loglikelihood: -3.79991e+06	(delta): 146.707
    16 (QN/Block) 	Elapsed: 0.825	Loglikelihood: -3.79989e+06	(delta): 13.1942
    17 (QN/Block) 	Elapsed: 0.951	Loglikelihood: -3.79989e+06	(delta): 4.60747
    18 (QN/Block) 	Elapsed: 0.754	Loglikelihood: -3.79989e+06	(delta): 1.50012
    19 (QN/Block) 	Elapsed: 0.777	Loglikelihood: -3.79989e+06	(delta): 0.128916
    20 (QN/Block) 	Elapsed: 0.768	Loglikelihood: -3.79989e+06	(delta): 0.00182983
    21 (QN/Block) 	Elapsed: 0.774	Loglikelihood: -3.79989e+06	(delta): 4.33787e-05
    Summary: 
    Converged in 21 iterations (20.351 sec)
    Loglikelihood: -3799887.171935
    Fst divergences between estimated populations: 
    	Pop0	Pop1	
    Pop0	
    Pop1	0.163	
    Pop2	0.073	0.156	
    Writing output files.


The `P` matrix contains estimated allele frequencies of the inferred ancestral populations.


```julia
P
```




    13928×3 Array{Float64,2}:
     0.99999   0.99999   0.99999
     0.946581  0.934992  0.901852
     0.989626  0.382598  0.918612
     0.973109  0.682057  0.907595
     0.678695  0.918927  0.129153
     0.99999   0.99999   0.99999
     0.99999   0.990119  0.99999
     0.841989  0.203466  0.851233
     0.967501  0.86069   0.622157
     0.870693  0.862778  0.842376
     0.99999   0.99999   0.99999
     0.279564  0.830299  0.224164
     0.777817  0.555361  0.950294
     ⋮                   
     0.746245  0.769682  0.753071
     0.7462    0.769957  0.752793
     0.752064  0.734527  0.753725
     0.745593  0.769889  0.754917
     0.749709  0.769826  0.755746
     0.717428  0.67002   0.702682
     0.745593  0.769889  0.754917
     0.745593  0.769889  0.754917
     0.749937  0.767978  0.755766
     0.99999   0.996706  0.99999
     0.978953  0.982035  0.926256
     0.99999   0.993413  0.992614



The `Q` matrix contains the estimated ancestry fractions.


```julia
Q
```




    324×3 Array{Float64,2}:
     1.0e-5    0.896321  0.103669
     0.009659  0.830876  0.159465
     0.05577   0.725441  0.21879
     1.0e-5    0.866447  0.133543
     0.029255  0.88897   0.081775
     0.009302  0.859576  0.131122
     1.0e-5    0.715624  0.284366
     0.013736  0.810352  0.175913
     1.0e-5    0.727122  0.272868
     0.03487   0.821125  0.144004
     1.0e-5    0.886316  0.113674
     0.011359  0.863532  0.125109
     1.0e-5    0.856018  0.143972
     ⋮                   
     1.0e-5    0.99998   1.0e-5
     1.0e-5    0.99998   1.0e-5
     1.0e-5    0.99998   1.0e-5
     1.0e-5    0.99998   1.0e-5
     1.0e-5    0.99998   1.0e-5
     1.0e-5    0.99998   1.0e-5
     1.0e-5    0.99998   1.0e-5
     1.0e-5    0.99998   1.0e-5
     1.0e-5    0.99998   1.0e-5
     1.0e-5    0.99998   1.0e-5
     1.0e-5    0.99998   1.0e-5
     0.004387  0.995603  1.0e-5



The output files of ADMIXTURE are available in the working directory.


```julia
readdir(glob"hapmap3.3.*")
```




    2-element Array{String,1}:
     "hapmap3.3.P"
     "hapmap3.3.Q"



## Detailed options

The `admixture` function wraps most options for running ADMIXTURE program. The keywords closely follow those of ADMIXTURE.
```docs
admixture
```

## Run ADMIXTURE directly

ADMIXTURE.jl exports `ADMIXTURE_EXE`, which points to the installed ADMIXTURE executable. Users can use it to run ADMIXTURE directly. For example,
```julia
run(`$ADMIXTURE_EXE hapmap3/hapmap3.bed 3`)
```

## References

The methodology is described in following papers. Please cite if you ADMIXTURE or ADMIXTURE.jl.

1. D Alexander, J Novembre, and K Lange. (2009) Fast model-based estimation of ancestry in unrelated individuals, _Genome Research_, 19(9):1655–1664. <https://dx.doi.org/10.1101/gr.094052.109>  

2. D Alexander and K Lange. (2011) Enhancements to the ADMIXTURE algorithm for individual ancestry estimation. _BMC Bioinformatics_, 12:246. <https://doi.org/10.1186/1471-2105-12-246>  

3. S Shringarpure, C Bustamante, K Lange, and D Alexander. (2016) Efficient analysis of large datasets and sex bias with ADMIXTURE. _BMC Bioinformatics_ 17:218. <https://doi.org/10.1186/s12859-016-1082-x>


```julia
# clean up the HAPMAP3 files
rm("hapmap3.3.P", force = true)
rm("hapmap3.3.Q", force = true)
rm("hapmap3.tar", force = true)
rm("hapmap3", recursive = true)
```

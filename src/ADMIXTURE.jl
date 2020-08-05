module ADMIXTURE

using DelimitedFiles, Glob, Pkg.Artifacts

export ADMIXTURE_EXE
export admixture, read_PQ

if Sys.isapple()
    ADMIXTURE_EXE = joinpath(artifact"ADMIXTURE", "dist/admixture_macosx-1.3.0/admixture")
elseif Sys.islinux()
    ADMIXTURE_EXE = joinpath(artifact"ADMIXTURE", "dist/admixture_linux-1.3.0/admixture")
else
    error("ADMIXTURE only supports Linux and MacOS")
end

"""
    admixture(inputFile, K; kwargs...)

Calculate the admixture estimates assuming `K` populations. Input file can be 
`.bed` (together with `.bim`, binary PLINK format), `geno` (STRUCTURE format), 
or `ped` (12-coding PLINK format). 

# Keyword arguments
- `B`: compute standard errors by bootstrap; default is `nothing`.  
- `j`: number of threads to be used; default is `nothing`.
- `s`: random seed; integer or `:time`; default is `nothing`. 
- `C`: major convergence criterion; float or integer; default is `nothing`. 
- `c`: minor convergence criterion; float or integer; default is `nothing`.
- `qn`: secant pairs to be used in quasi-Newton acceleration; default is 3.
- `l`: tuning parameter in penalized estimation.
- `e`: tuning parameter in penalized estimation.
"""
function admixture(
    inputFile :: AbstractString, 
    K         :: Integer;
    B         :: Union{Nothing,Integer} = nothing,
    j         :: Union{Nothing,Integer} = nothing,
    cv        :: Union{Nothing,Integer} = nothing,
    s         :: Union{Nothing,Integer,Symbol} = nothing,
    C         :: Union{Nothing,Real} = nothing,
    c         :: Union{Nothing,Real} = nothing,
    qn        :: Union{Nothing,Integer} = nothing,
    l         :: Union{Nothing,Number} = nothing,
    e         :: Union{Nothing,Number} = nothing
    )
    inputPath = inputFile |> abspath |> normpath
    args  = sizehint!(String[], 12)
    isnothing(B)  || push!(args, isinteger(B) ? "-B$B" : "-B")
    isnothing(j)  || push!(args, "-j$j")
    isnothing(cv) || push!(args, "--cv=$cv")
    isnothing(s)  || push!(args, isinteger(s) ? "-s $s" : "-s time")
    isnothing(C)  || push!(args, "-C $C")
    isnothing(c)  || push!(args, "-c $c")
    isnothing(qn) || push!(args, qn == 0 ? "-a none" : "-a qn$qn")
    isnothing(l)  || isnothing(e) || push!(args, "-l $l", "-e $e")
    cmd  = `$ADMIXTURE_EXE $inputPath $K $args`
    @info "ADMIXTURE command:\n$cmd\n"
    @info "Output directory: $(pwd())\n"
    run(cmd)
    outputPath = joinpath(pwd(), splitpath(inputPath)[end][1:end-4] * ".$K")
    P, Q = read_PQ(outputPath, args=args)
end

"""
    read_PQ(outputFile)

Read the P (allele frequencies of the inferred ancestral populations) and 
Q (the ancestry fractions) estimates output by the ADMIXTURE program.

# Keyword arguments  
- `T`:: output data type; default is `Float64`.
- `args`:: parsed ADMIXTURE arguments as a `Vector{String}`; default is empty.
"""
function read_PQ(
    outputFile :: AbstractString;
    T          :: Type = Float64,
    args       :: Vector{String} = String[]
    )
    pfile = normpath(abspath(outputFile)) * ".P"
    qfile = normpath(abspath(outputFile)) * ".Q"
    if any(arg -> occursin("-l ", arg), args)
        # penalized estimates have different file name endings
        # assume unique file ending with P.lambda.* and Q.lambda.*
        pfile = glob("$(basename(pfile)).lambda.*", pwd())[1]
        qfile = glob("$(basename(qfile)).lambda.*", pwd())[1]
    end
    P = readdlm(pfile, ' ', T)
    Q = readdlm(qfile, ' ', T)
    P, Q
end

end # module

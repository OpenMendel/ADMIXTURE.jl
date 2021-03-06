module PkgTest

using ADMIXTURE, Tar, Test

@info "Download HAPMAP3 data"
download("http://dalexander.github.io/admixture/hapmap3-files.tar.gz", 
         joinpath(pwd(), "hapmap3.tar"))
Tar.extract("hapmap3.tar", joinpath(pwd(), "hapmap3"))
HAPMAP3_FILE = "hapmap3/hapmap3"

@testset "help" begin
run(`$ADMIXTURE_EXE --help`)
end

@testset "hapmap3.bed (default)" begin
k = 3
P, Q = admixture(HAPMAP3_FILE * ".bed", k)
@test size(P) == (13928, 3)
@test size(Q) == (324, 3)
pfile = "hapmap3.$k.P"
qfile = "hapmap3.$k.Q"
@test isfile(qfile)
@test isfile(pfile)
rm(qfile, force = true)
rm(pfile, force = true)
end

@testset "hapmap3.bed (-j4, -B3, -c, -s)" begin
k = 3
P, Q = admixture(HAPMAP3_FILE * ".bed", k, 
j=8, B=3, C=5, c=5, s=123)
@test size(P) == (13928, 3)
@test size(Q) == (324, 3)
pfile = "hapmap3.$k.P"
qfile = "hapmap3.$k.Q"
sfile = "hapmap3.$k.Q_se"
bfile = "hapmap3.$k.Q_bias"
@test isfile(qfile)
@test isfile(pfile)
@test isfile(sfile)
@test isfile(bfile)
rm(qfile, force = true)
rm(pfile, force = true)
rm(sfile, force = true)
rm(bfile, force = true)
end

@testset "hapmap3.bed (-l, -e)" begin
k, l, e = 3, 500, 0.1
P, Q = admixture(HAPMAP3_FILE * ".bed", k, l=l, e=e, j=8, C=5)
@test size(P) == (13928, 3)
@test size(Q) == (324, 3)
pfile = "hapmap3.$k.P.lambda.$l"
qfile = "hapmap3.$k.Q.lambda.$l"
@test isfile(qfile)
@test isfile(pfile)
rm(qfile, force = true)
rm(pfile, force = true)
end

@info "Clean up HAPMAP3 data"
rm("hapmap3.tar", force = true)
rm("hapmap3", recursive = true)

end # module PkgTest

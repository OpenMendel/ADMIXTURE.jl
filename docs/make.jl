using Documenter, ADMIXTURE

makedocs(
    format = Documenter.HTML(),
    sitename = "ADMIXTURE.jl",
    authors = "Hua Zhou",
    clean = true,
    debug = true,
    pages = [
        "index.md"
    ]
)

deploydocs(
    repo   = "github.com/OpenMendel/ADMIXTURE.jl.git",
    target = "build",
    deps   = nothing,
    make   = nothing
)

using Documenter, DataUtils

makedocs(
    debug = true,
    strict = false,
    doctest = false,
    format = :html,
    sitename = "DataUtils.jl",
    modules = [DataUtils],
    pages = [
        "index.md"
    ]
)

deploydocs(
    repo = "github.com/jlapeyre/DataUtils.jl.git",
    target = "build",
    julia  = "nightly",
    deps = nothing,
    make = nothing
)

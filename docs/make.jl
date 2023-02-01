using LinearElasticityRecipes
using Documenter

DocMeta.setdocmeta!(LinearElasticityRecipes, :DocTestSetup, :(using LinearElasticityRecipes); recursive=true)

makedocs(;
    modules=[LinearElasticityRecipes],
    authors="singularitti <singularitti@outlook.com> and contributors",
    repo="https://github.com/MineralsCloud/LinearElasticityRecipes.jl/blob/{commit}{path}#{line}",
    sitename="LinearElasticityRecipes.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://MineralsCloud.github.io/LinearElasticityRecipes.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/MineralsCloud/LinearElasticityRecipes.jl",
    devbranch="main",
)

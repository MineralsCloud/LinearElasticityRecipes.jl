module LinearElasticityRecipes

using LinearElasticity:
    EngineeringStrain, EngineeringStress, TensorStrain, TensorStress, isuniaxial
using RecipesBase

@recipe function f(
    ๐::AbstractVector{<:EngineeringStrain}, ๐::AbstractVector{<:EngineeringStress}
)
    xguide --> "strains"
    yguide --> "stresses"
    framestyle --> :box
    legend_foreground_color --> nothing
    grid --> nothing
    @assert all(isuniaxial(ฯต) for ฯต in ๐)
    indices = unique(only(findall(!iszero, ฯต)) for ฯต in ๐)
    @assert length(indices) == 1
    i = only(indices)
    ๐แตข = map(Base.Fix2(getindex, i), ๐)
    for j in 1:6
        ๐โฑผ = map(Base.Fix2(getindex, j), ๐)
        @series begin
            seriestype --> :scatter
            markershape --> :circle
            markersize --> 2
            markerstrokecolor --> :auto
            markerstrokewidth --> 0
            label --> "\$c_{$i $j}\$"
            ๐แตข, ๐โฑผ
        end
    end
    for (line, T) in zip((:hline, :vline), eltype.((๐[1], ๐แตข)))
        @series begin
            seriestype --> line
            seriescolor --> :black
            z_order --> :back
            label := ""
            zeros(T, 1)
        end
    end
end
@recipe function f(๐::AbstractVector{<:TensorStrain}, ๐::AbstractVector{<:TensorStress})
    return EngineeringStrain.(๐), EngineeringStress.(๐)
end

end

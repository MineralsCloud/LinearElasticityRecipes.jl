module LinearElasticityRecipes

using LinearElasticity:
    EngineeringStrain, EngineeringStress, TensorStrain, TensorStress, isuniaxial
using RecipesBase

@recipe function f(
    𝛜::AbstractVector{<:EngineeringStrain}, 𝛔::AbstractVector{<:EngineeringStress}
)
    xguide --> "strains"
    yguide --> "stresses"
    framestyle --> :box
    legend_foreground_color --> nothing
    grid --> nothing
    @assert all(isuniaxial(ϵ) for ϵ in 𝛜)
    indices = unique(only(findall(!iszero, ϵ)) for ϵ in 𝛜)
    @assert length(indices) == 1
    i = only(indices)
    𝛜ᵢ = map(Base.Fix2(getindex, i), 𝛜)
    for j in 1:6
        𝛔ⱼ = map(Base.Fix2(getindex, j), 𝛔)
        @series begin
            seriestype --> :scatter
            markershape --> :circle
            markersize --> 2
            markerstrokecolor --> :auto
            markerstrokewidth --> 0
            label --> "\$c_{$i $j}\$"
            𝛜ᵢ, 𝛔ⱼ
        end
    end
    for (line, T) in zip((:hline, :vline), eltype.((𝛔[1], 𝛜ᵢ)))
        @series begin
            seriestype --> line
            seriescolor --> :black
            z_order --> :back
            label := ""
            zeros(T, 1)
        end
    end
end
@recipe function f(𝛜::AbstractVector{<:TensorStrain}, 𝛔::AbstractVector{<:TensorStress})
    return EngineeringStrain.(𝛜), EngineeringStress.(𝛔)
end

end

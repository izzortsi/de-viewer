using GLMakie
GLMakie.inline!(false)

# %%
 
fig = Figure(resolution = (900, 900), fontsize = 20)
ax1 = Axis(fig[1, 1], xlabel = L"\frac{dx}{dt}", ylabel = L"\frac{dy}{dt}", title = "Stable Van Der Pol", aspect = 1, backgroundcolor = :white)
deregister_interaction!(ax1, :rectanglezoom)
# %%
xs = LinRange(-4, 4, 40)
ys = LinRange(-4, 4, 40)

f₁(x, y, μ) = y
f₁(μ) = (x, y) -> f₁(x, y, μ)

f₂(x, y, μ) = μ*(1-x^2)*y-x
f₂(μ) = (x, y) -> f₂(x, y, μ)

limits!(ax1, -4, 4, -4, 4)

# %%
# us = [f₁(1)(x, y) for x in xs, y in ys]
# vs = [f₂(1)(x, y) for x in xs, y in ys]
# strength = vec(sqrt.(us .^ 2 .+ vs .^ 2))
# # %%


# %%
# arrows!(xs, ys, us, vs, normalize=true, arrowsize=3.5, lengthscale=0.08,
# arrowcolor = strength, linecolor = strength)
# %%


# %%

μs = -1:0.1:10
# %%
μ_lslider = labelslider!(fig, 
            L"\mu",
            μs;
            formats = [x -> "$(round(x, digits = 1))" for s in [L"\mu"]],
            width = 500,
            height=25)
# %%
fig[2, 1] = μ_lslider.layout
# %%
μ_slider = μ_lslider.slider
# %%

f₁_μ = @lift(f₁($(μ_slider.value)))
f₂_μ = @lift(f₂($(μ_slider.value)))
# %%

node_us = @lift([$f₁_μ(x, y) for x in xs, y in ys])
node_vs = @lift([$f₂_μ(x, y) for x in xs, y in ys])
strength = @lift(vec(sqrt.($node_us .^ 2 .+ $node_vs .^ 2)))

# %%
arrows!(xs, ys, node_us, node_vs, normalize=true, arrowsize=3.5, lengthscale=0.08,
arrowcolor = strength, linecolor = strength)

# %%
fig
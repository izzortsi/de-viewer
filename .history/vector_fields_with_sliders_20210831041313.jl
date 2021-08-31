using GLMakie
GLMakie.inline!(false)

# %%
 
fig = Figure(resolution = (900, 900), fontsize = 20)
ax1 = Axis(fig[1, 1], xlabel = L"\frac{dx}{dt}", ylabel = L"\frac{dy}{dt}", title = "Stable Van Der Pol", aspect = 1, backgroundcolor = :black)
deregister_interaction!(ax1, :rectanglezoom)
# %%
xs = LinRange(-4, 4, 90)
ys = LinRange(-4, 4, 90)

f₁(x, y, μ) = y
f₁(μ) = (x, y) -> f₁(x, y, μ)
f₂(x, y, μ) = μ*(1-x^2)*y-x
f₂(μ) = (x, y) -> f₂(x, y, μ)
limits!(ax1, -4, 4, -4, 4)

# %%
points = [f(1).(x, y) for x in xs, y in ys]
# %%


# %%
arrows!(xs, ys, points)
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

f_μ = @lift(f($(μ_slider.value)))
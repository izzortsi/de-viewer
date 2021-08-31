# %%

using GLMakie
GLMakie.inline!(false)
# %%

f(x, y, μ) = Point2(y, μ*(1-x^2)*y -x)
f(μ) = (x, y) -> f(x, y, μ)
# %%

fig = Figure(resolution = (900, 900), fontsize = 20)
ax1 = fig[1, 1] = Axis(fig, xlabel = L"\frac{dx}{dt}", ylabel = L"\frac{dy}{dt}", title = "Stable Van Der Pol", aspect = 1, backgroundcolor = :black)

streamplot!(ax1, f(1), -4..4, -4..4, colormap = Reverse(:plasma),
    gridsize= (90,90), arrow_size=0.08)

limits!(ax1, -4, 4, -4, 4)

fig
#save("streamplots3.png", fig, px_per_unit = 2)
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

# %%

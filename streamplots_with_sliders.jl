# %% 
using GLMakie
GLMakie.inline!(false)

# %%
 
fig = Figure(resolution = (900, 900), fontsize = 20)
#ax1 = Axis(fig[1, 1], xlabel = L"\frac{dx}{dt}", ylabel = L"\frac{dy}{dt}", title = "Stable Van Der Pol", aspect = 1, backgroundcolor = :black)
#deregister_interaction!(ax1, :rectanglezoom)
# %%
xs = LinRange(-4, 4, 90)
ys = LinRange(-4, 4, 90)

f(x, y, μ) = Point2(y, μ*(1-x^2)*y -x)
f(μ) = (x, y) -> f(x, y, μ)
# %%
limits!(ax1, -4, 4, -4, 4)
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


# %%

# points = @lift($f_λ.(ts, xs))
# # %%
# points[]
# # %%

# lines!(ts, points, color = :red)
# %%
# stream = streamplot!(ax1, f_μ[], xs, ys, colormap = Reverse(:plasma),
#     gridsize= (90,90), arrow_size=0.08)

# fig
# # %%
# stream[1][] = f_μ[]

# # %%
# f_μ
# %%

stream = streamplot!(fig[1, 1], f_μ[], xs, ys, colormap = Reverse(:plasma),
    gridsize= (90,90), arrow_size=0.08)


# streamplot!(ax1, f(1), -4..4, -4..4, colormap = Reverse(:plasma),
#     gridsize= (90,90), arrow_size=0.08)
stream[1]

# %%

fig

# %%

using Makie

# %%
Makie.streamplot_impl
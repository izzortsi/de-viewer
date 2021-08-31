# %%

using GLMakie
# %%

f(x, y, μ) = Point(y, μ*(1-x^2)*y -x)

fig = Figure(resolution = (900, 400), fontsize = 20)
ax1 = fig[1, 1] = Axis(fig, xlabel = "x", ylabel = "y", title = "Stable Van Der Pol",
aspect = 1, backgroundcolor = :black)
ax2 = fig[1, 2] = Axis(fig, xlabel = "x", title = "stable",
aspect = 1,backgroundcolor = :black)
ax3 = fig[1, 3] = Axis(fig, xlabel = "x", title = "semi-stable",
aspect = 1, backgroundcolor = :black)

streamplot!(ax1, nonStablePoincare, -4..4, -4..4, colormap = Reverse(:plasma),
    gridsize= (32,32), arrow_size = 10)
streamplot!(ax2, f, -4..4, -4..4, colormap = Reverse(:viridis),
    gridsize= (32,32), arrow_size = 10)
streamplot!(ax3, semiStable, -4..4, -4..4, colormap = Reverse(:inferno),
    gridsize= (32,32), arrow_size = 10)

hideydecorations!(ax2, grid = false)
hideydecorations!(ax3, grid = false)

limits!(ax1, -4, 4, -4, 4)
limits!(ax2, -4, 4, -4, 4)
limits!(ax3, -4, 4, -4, 4)

fig
#save("streamplots3.png", fig, px_per_unit = 2)

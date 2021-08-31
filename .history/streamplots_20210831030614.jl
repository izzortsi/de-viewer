# %%

using GLMakie
# %%

f(x, y, μ) = Point2(y, μ*(1-x^2)*y -x)

fig = Figure(resolution = (900, 400), fontsize = 20)
ax1 = fig[1, 1] = Axis(fig, xlabel = L"\frac{dx}{dt}", ylabel = L"\frac{dy}{dt}", title = "Stable Van Der Pol", aspect = 1, backgroundcolor = :black)

streamplot!(ax1, f, -4..4, -4..4, colormap = Reverse(:plasma),
    gridsize= (32,32), arrow_size = 10)

limits!(ax1, -4, 4, -4, 4)

fig
#save("streamplots3.png", fig, px_per_unit = 2)

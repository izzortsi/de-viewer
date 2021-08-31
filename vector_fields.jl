using GLMakie
Dₓ(x, y) = -x*(cos(x) -2)
xs = LinRange(-3, 3, 20)
ys = LinRange(-3, 3, 20)
vs = [Dₓ(y, x) for x in xs, y in ys]
us = [1 for x in xs, y in ys]
strength = vec(sqrt.(us .^2 .+ vs .^2))
fig = Figure(resolution = (550, 450), fontsize = 18, font = "sans")
ax = Axis(fig, xlabel = "x", ylabel = "y", aspect = 1)
arrows!(ax, xs, ys, us, vs, arrowsize = 10, lengthscale = 0.1,
    arrowcolor = strength, linecolor = strength, colormap = :plasma)
cbar = Colorbar(fig, limits =(minimum(strength),maximum(strength)),
nsteps =100, colormap = :plasma, ticksize=15, width = 15, tickalign=1)
limits!(ax, -3,3,-3,3)
fig[1,1] = ax
fig[1,2] = cbar
fig
 #save("arrows.png", fig, px_per_unit = 2)
# %%
Dₓ(x, t) = -x*(cos(x) -2)
# %%

function parametrized_vector_field(f::Function, f_range::LinRange, α::Float64, α_range::LinRange)
   ts = f_range
   xs = f_range
   Dₜ = [f.(x, t) for t in ts, x in xs ]
   t = [1 for t in ts, x in xs]

   fig = Figure(resolution = (550, 450), fontsize = 18, font = "sans")
   ax = Axis(fig, xlabel = "x", ylabel = "y", aspect = 1)
   arrows!(ax, ts, xs, t, Dₜ, arrowsize = 10, lengthscale = 0.1,
       arrowcolor = strength, linecolor = strength, colormap = :plasma)
    fig[1,1] = ax
    fig[1,2] = cbar
    fig
end

# %%

parametrized_vector_field(Dₓ, LinRange(-1, 1, 10), 2., LinRange(-1, 1, 10))

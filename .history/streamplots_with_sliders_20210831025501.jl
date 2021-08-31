# %% 
using Makie, GLMakie
Makie.inline!(false)


# %%
# f(t, x, a) = t*x^2 - a*x^6
# f(a) = (t, x) -> f(t, x, a) 
# %%
#fs = f.(λs)

# %%
# f(t, x, a) = a - x^3 +12*x - 36*x
# f(a) = (t, x) -> f(t, x, a) 
f(t, x, a) =  a*x^4 + 12*x^2 + a
f(a) = ((t, x) -> f(t, x, a)) 
# %%
 
fig = Figure(resolution = (1000, 1000))
ax1 = Axis(fig[1, 1], width = 900, ylabel=L"f_{\lambda}(t, x(t))", xlabel = L"t")
ax1.aspect[] = 1
deregister_interaction!(ax1, :rectanglezoom)
# %%
ts = LinRange(-50, 50, 200)
xs = LinRange(-2, 2, 200)
λs = -5:0.1:5
# %%
ylims!(-100,100)
xlims!(-100,100)
# %%
vlines!(ax1, [0], color = :black)
hlines!(ax1, [0], color = :black)
# %%

  
arrows!(ax1, [0, 0], [0, 0], [10, 0], [0, 10])
# arrows!(ax1, [0, 0], [0, 0], [0], [1])

λ_lslider = labelslider!(fig, 
            L"\lambda",
            λs;
            formats = [x -> "$(round(x, digits = 1))" for s in [L"\lambdas"]],
            width = 500,
            height=25)
# %%
fig[2, 1] = λ_lslider.layout
# %%
λ_slider = λ_lslider.slider
# %%

f_λ = @lift(f($(λ_slider.value)))
# %%
f_λ[](1, 2)

# %%

points = @lift($f_λ.(ts, xs))
# %%
points[]
# %%

lines!(ts, points, color = :red)
# %%
fig

# %%

# point = lift(λ_slider.value) do a
#     "$a"
# end
# # %%
# text!(ax1, point, position = (2,2), align = (:center, :center))
# fig

# # %%

# sndpoint = @lift("$($(λ_slider.value))")
# text!(ax1, sndpoint, position = (-2,2), align = (:center, :center))
# # %%
# fig
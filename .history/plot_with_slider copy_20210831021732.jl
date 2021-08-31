# %%
 
using Makie, GLMakie
Makie.inline!(false)


# %%
f(t, x, a) = x^2 - a*x^6
f(a) = (t, x) -> f(t, x, a) 
# %%
#fs = f.(λs)

# %%

 
fig = Figure(resolution = (600, 600))
ax1 = Axis(fig[1, 1])
ax1.aspect[] = 1
deregister_interaction!(ax1, :rectanglezoom)
# %%
ts = LinRange(-10, 10, 200)
xs = LinRange(-10, 10, 200)
λs = -5:0.1:5
# %%
ylims!(-10,10)
xlims!(-10,10)
# %%
vlines!(ax1, [0], color = :black)
hlines!(ax1, [0], color = :black)
# %%

  
arrows!(ax1, [0, 0], [0, 0], [5, 0], [0, 5])
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

 
# %%
fig
# %%
λ_slider = λ_lslider.slider
# %%

point = lift(λ_slider.value) do a
    "$a"
end
# %%
text!(ax1, point, position = (2,2), align = (:center, :center))
fig

# %%

sndpoint = @lift("$($(λ_slider.value))")
text!(ax1, sndpoint, position = (-2,2), align = (:center, :center))
# %%
fig
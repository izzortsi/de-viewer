# %%
 
using WGLMakie
#Makie.inline!(false)


# %%
f(t, x, a) = x^2 - a*x^6
f(a) = (t, x) -> f(t, x, a) 
# %%
fs = f.(λs)

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
fig
# %%
 
  
arrows!(ax1, [0, 0], [0, 0], [5, 0], [0, 5])
# arrows!(ax1, [0, 0], [0, 0], [0], [1])
# %%

#lines!(ax1, ts, xs)
 
# %%
fig
# %%
lsgrid = labelslidergrid!(
    fig,
    [L"\lambda"],
    [λs];
    formats = [x -> "$(round(x, digits = 1))" for s in [L"\lambdas"]],
    width = 500,
    height=25)

fig[2, 1] = lsgrid.layout
# %%
# λ_slider = lsgrid.sliders[1]
# # %% 
# fig 
# # %%
# λ_obs = λ_slider.value
# # %%
# f_node = Node(f)
# # %%
# f_λ = lift(f, λ_obs)
# # %% 
λ_obs = [s.value for s in lsgrid.sliders]
# %%

 

curves = lift(λ_obs...) do λ_vals...
    [λ_vals...]
end
# %%
lines!(ax1, ts, f(curves[][1]).(ts, xs))
 
# %%
fig
# %%

 
 
 

  
  
lsgrid = labelslidergrid!(
    fig,
    ["Voltage", "Current", "Resistance"],
    [0:0.1:10, 0:0.1:20, 0:0.1:30];
    formats = [x -> "$(round(x, digits = 1))$s" for s in ["V", "A", "Ω"]],
    width = 350,
    tellheight = false)

fig[1, 2] = lsgrid.layout

sliderobservables = [s.value for s in lsgrid.sliders]
bars = lift(sliderobservables...) do slvalues...
    [slvalues...]
end

barplot!(ax, bars, color = [:yellow, :orange, :red])
ylims!(ax, 0, 30)

set_close_to!(lsgrid.sliders[1], 5.3)
set_close_to!(lsgrid.sliders[2], 10.2)
set_close_to!(lsgrid.sliders[3], 15.9)

fig
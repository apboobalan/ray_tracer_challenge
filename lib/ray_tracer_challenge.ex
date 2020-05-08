defmodule RayTracerChallenge do
  alias RayTracer.Tuple
  alias RayTracer.{Canvas, Color}

  def next_projectile(env, proj) do
    position = proj.position |> Tuple.add(proj.velocity)
    velocity = proj.velocity |> Tuple.add(env.gravity) |> Tuple.add(env.wind)
    Projectile.new(position, velocity)
  end

  def loop(proj, env, acc \\ %{x: [], y: []}) do
    acc = %{x: [proj.position.x | acc.x], y: [proj.position.y | acc.y]}
    next_proj = env |> next_projectile(proj)

    if next_proj.position.y > 0 do
      loop(next_proj, env, acc)
    else
      acc
    end
  end

  defp normalize(x, y, opts) do
    x = (x/opts.max_w) * (opts.width - 5)
    inverted_y = (y/opts.max_h) * (opts.height - 5)
    y = opts.height - (inverted_y + 2)
    {x |> round, y |> round}
  end
  defp _draw_canvas(canvas, [], _opts), do: canvas
  defp _draw_canvas(canvas, [{x, y} | path], opts) do
    {x, y} = normalize(x, y, opts)
    canvas = canvas |> Canvas.write_pixel(x, y, Color.new(1, 0, 0))
    _draw_canvas(canvas, path, opts)
  end
  def draw_canvas(%{distance: p_width, height: p_height, path: path}, width, height) do
     _draw_canvas(Canvas.new(width, height), path, %{height: height, width: width, max_w: p_width, max_h: p_height})
  end
  def draw_projectile(width, height) do
    projectile_path = loop(Projectile.new(Tuple.point(0.0, 1.0, 0.0), Tuple.vector(1.0, 1.8, 0.0) |> Tuple.normalize |> Tuple.multiply(11.25)), Environment.new(Tuple.vector(0, -0.1, 0), Tuple.vector(-0.01, 0, 0)))
    %{distance: Enum.max(projectile_path.x),height: Enum.max(projectile_path.y), path: Enum.zip(projectile_path.x, projectile_path.y)}
    |> draw_canvas(width, height) |> Canvas.write
  end
end

defmodule Projectile do
  defstruct position: nil, velocity: nil

  def new(position, velocity), do: %__MODULE__{position: position, velocity: velocity}
end

defmodule Environment do
  defstruct gravity: nil, wind: nil

  def new(gravity, wind), do: %__MODULE__{gravity: gravity, wind: wind}
end


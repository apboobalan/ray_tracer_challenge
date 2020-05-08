defmodule RayTracer.Canvas do
  alias RayTracer.Color
  alias Helper.Helper

  @moduledoc """
  Operations regarding canvas.
  """

  @doc """
  Create new canvas of specified width and height with all black colors.
  """
  @spec new(non_neg_integer, non_neg_integer) :: tuple
  def new(width, height), do: new(width, height, Color.black())

  @doc """
  Create new canvas of specified widht, height and color.
  """
  @spec new(non_neg_integer, non_neg_integer, Color.t()) :: tuple
  def new(width, height, color), do: Tuple.duplicate(color, width) |> Tuple.duplicate(height)

  @doc """
  Write a color at a pixel in canvas.
  """
  @spec write_pixel(tuple, non_neg_integer, non_neg_integer, Color.t()) :: tuple
  def write_pixel(canvas, x, y, color) do
    row = canvas |> elem(y) |> put_elem(x, color)
    canvas |> put_elem(y, row)
  end

  @doc """
  Get color at a pixel in canvas.
  """
  @spec pixel_at(tuple, non_neg_integer, non_neg_integer) :: Color.t()
  def pixel_at(canvas, x, y) do
    canvas |> elem(y) |> elem(x)
  end

  @spec to_ppm(tuple) :: String.t()
  def to_ppm(canvas) do
    height = canvas |> tuple_size
    width = canvas |> elem(0) |> tuple_size

    ppm_header = ["P3", "\n", "#{width} #{height}", "\n", "255", "\n"]

    (ppm_header ++ _canvas_color_to_ppm(canvas)) |> :erlang.list_to_binary()
  end

  def _canvas_color_to_ppm(canvas) do
    for row <- canvas |> :erlang.tuple_to_list() do
      row |> _row_color_to_ppm
    end
  end

  def _row_color_to_ppm(row) do
    row_ppm =
      for color <- row |> :erlang.tuple_to_list() do
        color |> Color.color_scale_0_255() |> Color.to_string()
      end

    row_ppm ++ ["\n"]
  end

  def write(canvas), do: canvas |> to_ppm |> Helper.write_to("canvas.ppm")

end

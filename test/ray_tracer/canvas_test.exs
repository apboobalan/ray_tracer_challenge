defmodule RayTracer.CanvasTest do
  use ExUnit.Case
  doctest RayTracer.Canvas
  alias RayTracer.{Canvas, Color}

  test "Create canvas of size with all pixels initialized to given color" do
    canvas = Canvas.new(10, 20, Color.new(1, 0.8, 0.6))

    for row <- canvas |> Tuple.to_list() do
      for c <- row |> Tuple.to_list() do
        assert Color.equal(c, Color.new(1, 0.8, 0.6))
      end
    end
  end

  test "Create canvas of size with all pixels initialized to black" do
    canvas = Canvas.new(10, 20)

    for row <- canvas |> Tuple.to_list() do
      for c <- row |> Tuple.to_list() do
        assert Color.equal(c, Color.new(0, 0, 0))
      end
    end
  end

  test "write color to a pixel in canvas" do
    red = Color.new(1, 0, 0)
    canvas = Canvas.new(10, 20) |> Canvas.write_pixel(2, 3, red)

    assert Color.equal(canvas |> Canvas.pixel_at(2, 3), red)
  end

  test "Construct PPM header" do
    ppm = Canvas.new(5, 3) |> Canvas.to_ppm
    assert String.starts_with?(ppm,"""
    P3
    5 3
    255
    """)
  end

  test "PPM ends with a new line" do
    ppm = Canvas.new(5, 3) |> Canvas.to_ppm
    assert String.ends_with?(ppm, "\n")
  end

  test "Constructing the PPM pixel data" do
    canvas = Canvas.new(5, 3)
    c1 = Color.new(1.5, 0 , 0)
    c2 = Color.new(0, 0.5, 0)
    c3 = Color.new(-0.5, 0, 1)

    canvas = canvas |> Canvas.write_pixel(0, 0, c1) |> Canvas.write_pixel(2, 1, c2) |> Canvas.write_pixel(4, 2, c3)
    assert Canvas.to_ppm(canvas) == "P3\n5 3\n255\n255 0 0 0 0 0 0 0 0 0 0 0 0 0 0 \n0 0 0 0 0 0 0 128 0 0 0 0 0 0 0 \n0 0 0 0 0 0 0 0 0 0 0 0 0 0 255 \n"
  end
end

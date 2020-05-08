defmodule RayTracer.ColorTest do
  use ExUnit.Case
  doctest RayTracer.Color
  alias RayTracer.Color

  test "Create a color tuple" do
  color = Color.new(1, 1, 1)

  assert color.red == 1
  assert color.green == 1
  assert color.blue == 1
  end

  test "Create black color" do
    black = Color.black

    assert black.red == 0
    assert black.green == 0
    assert black.blue == 0
  end

  test "Check equal colors" do
    assert Color.equal(Color.new(1, 1, 1), Color.new(1.000009, 1.000001, 0.99999))
  end

  test "Add colors" do
    c1 = Color.new(0.9, 0.6, 0.75)
    c2 = Color.new(0.7, 0.1, 0.25)

    assert Color.equal(Color.add(c1, c2), Color.new(1.6, 0.7, 1.0))
  end

  test "Subtract colors" do
    c1 = Color.new(0.9, 0.6, 0.75)
    c2 = Color.new(0.7, 0.1, 0.25)

    assert Color.equal(Color.subtract(c1, c2), Color.new(0.2, 0.5, 0.5))
  end

  test "Multiply color by a scalar" do
    c1 = Color.new(0.2, 0.3, 0.4)

    assert Color.equal(Color.scalar_product(c1, 2), Color.new(0.4, 0.6, 0.8))
  end

  test "Multiply colors" do
    c1 = Color.new(1, 0.2, 0.4)
    c2 = Color.new(0.9, 1, 0.1)

    assert Color.equal(Color.product(c1, c2), Color.new(0.9, 0.2, 0.04))
  end

  test "Scale color between 0 and 255" do
    c = Color.new(-0.5, 0.5, 1.5)

    assert Color.equal(Color.color_scale_0_255(c), Color.new(0, 127.5, 255))
  end

  test "Convert color to string" do
    c = Color.new(255, 104, 153)

    assert Color.to_string(c) == "255 104 153 "
  end

end

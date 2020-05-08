defmodule RayTracer.TupleTest do
  use ExUnit.Case
  doctest RayTracer.Tuple
  alias RayTracer.Tuple
  alias Helper.Helper

  test "A tuple with 1 is a point" do
    tuple = Tuple.new(4.2, -4.2, 3.1, 1.0)

    assert tuple.x == 4.2
    assert tuple.y == -4.2
    assert tuple.z == 3.1
    assert tuple |> Tuple.type() == :point
    assert tuple |> Tuple.type() != :vector
  end

  test "A tuple with 0 is a vector" do
    tuple = Tuple.new(4.2, -4.2, 3.1, 0.0)

    assert tuple.x == 4.2
    assert tuple.y == -4.2
    assert tuple.z == 3.1
    assert tuple |> Tuple.type() == :vector
    assert tuple |> Tuple.type() != :point
  end

  test "point() creates tuple with w=1" do
    point = Tuple.point(4.2, -4.2, 3.1)

    assert point == Tuple.new(4.2, -4.2, 3.1, 1.0)
  end

  test "vector() creates tuple with w=0" do
    vector = Tuple.vector(4.2, -4.2, 3.1)

    assert vector == Tuple.new(4.2, -4.2, 3.1, 0.0)
  end

  test "checking whether two tuples are equal" do
    tuple1 = Tuple.vector(4.2, -4.2, 3.1)
    tuple2 = Tuple.vector(4.200000001, -4.200000005, 3.099999)

    assert Tuple.equal(tuple1, tuple2)
  end

  test "Adding a point and a vector" do
    point = Tuple.point(4.2, -4.2, 3.1)
    vector = Tuple.vector(3.1, -6.1, 2.2)

    assert Tuple.equal(Tuple.add(point, vector), Tuple.point(7.3, -10.3, 5.3))
  end

  test "Adding a vector and a point" do
    point = Tuple.point(4.2, -4.2, 3.1)
    vector = Tuple.vector(3.1, -6.1, 2.2)

    assert Tuple.equal(Tuple.add(vector, point), Tuple.point(7.3, -10.3, 5.3))
  end

  test "Adding two vectors" do
    v1 = Tuple.vector(4.2, -4.2, 3.1)
    v2 = Tuple.vector(3.1, -6.1, 2.2)

    assert Tuple.equal(Tuple.add(v1, v2), Tuple.vector(7.3, -10.3, 5.3))
  end

  test "Adding two points" do
    p1 = Tuple.point(4.2, -4.2, 3.1)
    p2 = Tuple.point(3.1, -6.1, 2.2)

    assert Tuple.add(p1, p2) == {:error, :CANNOT_ADD_TWO_POINTS}
  end

  test "Subtract vector from a point" do
    point = Tuple.point(4.2, -4.2, 3.1)
    vector = Tuple.vector(3.1, -6.1, 2.2)

    assert Tuple.equal(Tuple.subtract(point, vector), Tuple.point(1.1, 1.9, 0.9))
  end

  test "Subtract two vectors" do
    v1 = Tuple.vector(4.2, -4.2, 3.1)
    v2 = Tuple.vector(3.1, -6.1, 2.2)

    assert Tuple.equal(Tuple.subtract(v1, v2), Tuple.vector(1.1, 1.9, 0.9))
  end

  test "Subtract two points" do
    p1 = Tuple.point(4.2, -4.2, 3.1)
    p2 = Tuple.point(3.1, -6.1, 2.2)

    assert Tuple.equal(Tuple.subtract(p1, p2), Tuple.vector(1.1, 1.9, 0.9))
  end

  test "Subtract point from a vector" do
    point = Tuple.point(4.2, -4.2, 3.1)
    vector = Tuple.vector(3.1, -6.1, 2.2)

    assert Tuple.subtract(vector, point) == {:error, :CANNOT_SUBTRACT_POINT_FROM_A_VECTOR}
  end

  test "Negate tuple" do
    tuple = Tuple.new(3.1, -6.1, 2.2, 4.0)

    assert Tuple.negate(tuple) == Tuple.new(-3.1, 6.1, -2.2, -4.0)
  end

  test "Multiply tuple by a scalar" do
    tuple = Tuple.new(3.1, -6.1, 2.2, 4.0)

    assert Tuple.equal(Tuple.multiply(tuple, 3), Tuple.new(9.3, -18.3, 6.6, 12.0))
  end

  test "Divide tuple by a scalar" do
    tuple = Tuple.new(3.1, -6.1, 2.2, 4.0)

    assert Tuple.equal(Tuple.divide(tuple, 2), Tuple.new(1.55, -3.05, 1.1, 2.0))
  end

  test "Magnitude of a vector" do
    vector = Tuple.vector(1, 2, 3)

    assert Helper.equal(Tuple.magnitude(vector), :math.sqrt(14))
  end

  test "Magnitude of unit vectors" do
    v1 = Tuple.vector(1, 0, 0)
    v2 = Tuple.vector(0, 1, 0)
    v3 = Tuple.vector(0, 0, 1)

    assert Helper.equal(Tuple.magnitude(v1), 1)
    assert Helper.equal(Tuple.magnitude(v2), 1)
    assert Helper.equal(Tuple.magnitude(v3), 1)
  end

  test "Normalize a vector" do
    v = Tuple.vector(1, 2, 3)
    normalized_vector = Tuple.normalize(v)

    assert Tuple.equal(normalized_vector, Tuple.vector(0.26726, 0.53452, 0.80178))
    assert Helper.equal(Tuple.magnitude(normalized_vector), 1)
  end

  test "Dot product" do
    v1 = Tuple.vector(1, 2, 3)
    v2 = Tuple.vector(2, 3, 4)

    assert Helper.equal(Tuple.dot(v1, v2), 20)
  end

  test "Cross product of two vectors" do
    v1 = Tuple.vector(1, 2, 3)
    v2 = Tuple.vector(2, 3, 4)

    assert Tuple.equal(Tuple.cross(v1, v2), Tuple.vector(-1, 2, -1))
    assert Tuple.equal(Tuple.cross(v2, v1), Tuple.vector(1, -2, 1))
  end
end

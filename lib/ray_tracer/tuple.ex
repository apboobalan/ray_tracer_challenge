defmodule RayTracer.Tuple do
  @moduledoc """
  Operations regarding points, vectors and tuples.
  """
  alias Helper.Helper
  @type t :: %__MODULE__{
          x: number,
          y: number,
          z: number,
          w: number
        }
  @enforce_keys [:x, :y, :z, :w]
  defstruct x: 0.0, y: 0.0, z: 0.0, w: 1.0

  @doc """
  Create new Tuple.
  """
  @spec new(number, number, number, number) :: RayTracer.Tuple.t()
  def new(x, y, z, w) do
    %__MODULE__{x: x, y: y, z: z, w: w}
  end

  @doc """
  Detect type of tuple.
  """
  @spec type(RayTracer.Tuple.t()) :: :point | :vector
  def type(%__MODULE__{w: 1.0}), do: :point
  def type(%__MODULE__{w: 0.0}), do: :vector

  @doc """
  Create point.
  """
  @spec point(number, number, number) :: RayTracer.Tuple.t()
  def point(x, y, z), do: __MODULE__.new(x, y, z, 1.0)

  @doc """
  Create vector.
  """
  @spec vector(number, number, number) :: RayTracer.Tuple.t()
  def vector(x, y, z), do: __MODULE__.new(x, y, z, 0.0)

  @doc """
  Check equality of tuples.
  """
  @spec equal(RayTracer.Tuple.t(), RayTracer.Tuple.t()) :: boolean
  def equal(%__MODULE__{} = t1, %__MODULE__{} = t2) do
    Helper.equal(t1.x, t2.x) &&
    Helper.equal(t1.y, t2.y) &&
    Helper.equal(t1.z, t2.z) &&
    Helper.equal(t1.w, t2.w)
  end

  @doc """
  Add two tuples in a meaningful way.
  """
  @spec add(RayTracer.Tuple.t(), RayTracer.Tuple.t()) ::
          {:error, :CANNOT_ADD_TWO_POINTS} | RayTracer.Tuple.t()
  def add(%__MODULE__{w: 0.0} = t1, %__MODULE__{w: 1.0} = t2 ), do: _add(t1, t2)
  def add(%__MODULE__{w: 1.0} = t1, %__MODULE__{w: 0.0} = t2 ), do: _add(t1, t2)
  def add(%__MODULE__{w: 0.0} = t1, %__MODULE__{w: 0.0} = t2 ), do: _add(t1, t2)
  def add(%__MODULE__{w: 1.0} = _t1, %__MODULE__{w: 1.0} = _t2 ), do: {:error, :CANNOT_ADD_TWO_POINTS}

  defp _add(t1, t2), do: %__MODULE__{x: t1.x + t2.x, y: t1.y + t2.y, z: t1.z + t2.z, w: t1.w + t2.w}

  @doc """
  Subtract two tuples in a menaingful way.
  """
  @spec subtract(RayTracer.Tuple.t(), RayTracer.Tuple.t()) ::
  {:error, :CANNOT_SUBTRACT_POINT_FROM_A_VECTOR} | RayTracer.Tuple.t()
def subtract(%__MODULE__{w: 0.0} = _t1, %__MODULE__{w: 1.0} = _t2 ), do: {:error, :CANNOT_SUBTRACT_POINT_FROM_A_VECTOR}
def subtract(%__MODULE__{w: 1.0} = t1, %__MODULE__{w: 0.0} = t2 ), do: _subtract(t1, t2)
def subtract(%__MODULE__{w: 0.0} = t1, %__MODULE__{w: 0.0} = t2 ), do: _subtract(t1, t2)
def subtract(%__MODULE__{w: 1.0} = t1, %__MODULE__{w: 1.0} = t2 ), do: _subtract(t1, t2)

defp _subtract(t1, t2), do: %__MODULE__{x: t1.x - t2.x, y: t1.y - t2.y, z: t1.z - t2.z, w: t1.w - t2.w}

@doc """
Negate tuple.
"""
@spec negate(RayTracer.Tuple.t()) :: RayTracer.Tuple.t()
def negate(%__MODULE__{} = tuple), do: %__MODULE__{x: - tuple.x, y: -tuple.y, z: -tuple.z, w: -tuple.w}

@doc """
Multiply tuple with a scalar number.
"""
@spec multiply(RayTracer.Tuple.t(), number) :: RayTracer.Tuple.t()
def multiply(%__MODULE__{} = tuple, scale), do: %__MODULE__{x: tuple.x * scale, y: tuple.y * scale, z: tuple.z * scale, w: tuple.w * scale}

@doc """
Divide tupe by a scalar number.
"""
@spec divide(RayTracer.Tuple.t(), number) :: RayTracer.Tuple.t()
def divide(%__MODULE__{} = tuple, scale), do: %__MODULE__{x: tuple.x / scale, y: tuple.y / scale, z: tuple.z / scale, w: tuple.w / scale}

@doc """
Find magnitude of a tuple.
"""
@spec magnitude(RayTracer.Tuple.t()) :: number
def magnitude(%__MODULE__{} = tuple), do: :math.sqrt(tuple.x * tuple.x + tuple.y *tuple.y + tuple.z * tuple.z + tuple.w * tuple.w)

@doc """
Normalize a vector.
"""
@spec normalize(RayTracer.Tuple.t()) :: RayTracer.Tuple.t()
def normalize(%__MODULE__{} = tuple) do
  magnitude = tuple |> magnitude
  %__MODULE__{x: tuple.x/magnitude, y: tuple.y/magnitude, z: tuple.z/magnitude, w: tuple.w/magnitude}
end

@doc """
Dot product.
"""
@spec dot(RayTracer.Tuple.t(), RayTracer.Tuple.t()) :: number
def dot(%__MODULE__{} = t1, %__MODULE__{} = t2), do: t1.x * t2.x + t1.y * t2.y + t1.z * t2.z + t1.w * t2.w

@doc """
Cross product of two vectors.
"""
@spec cross(RayTracer.Tuple.t(), RayTracer.Tuple.t()) :: RayTracer.Tuple.t()
def cross(%__MODULE__{w: 0.0} = v1, %__MODULE__{w: 0.0} = v2) do
  vector(
    v1.y * v2.z - v1.z * v2.y,
    v1.z * v2.x - v1.x * v2.z,
    v1.x * v2.y - v1.y * v2.x
  )
end
end

defmodule RayTracer.Color do
  @moduledoc """
  Operations regarding color.
  """
  alias Helper.Helper
  @type t :: %__MODULE__{
    red: number,
    green: number,
    blue: number
  }
  @enforce_keys [:red, :green, :blue]
  defstruct red: 0, green: 0, blue: 0

  @doc """
  Create new color.
  """
  @spec new(number, number, number) :: RayTracer.Color.t()
  def new(red, green, blue), do: %__MODULE__{red: red, green: green, blue: blue}

  @doc """
  Constructs a black color.
  """
  @spec black :: RayTracer.Color.t()
  def black(), do: new(0, 0, 0)

  @doc """
  Check equality of colors.
  """
  @spec equal(RayTracer.Color.t(), RayTracer.Color.t()) :: boolean
  def equal(%__MODULE__{} = c1, %__MODULE__{} = c2) do
    Helper.equal(c1.red, c2.red) && Helper.equal(c1.green, c2.green) && Helper.equal(c1.blue, c2.blue)
  end

  @doc """
  Add colors.
  """
  @spec add(RayTracer.Color.t(), RayTracer.Color.t()) :: RayTracer.Color.t()
  def add(%__MODULE__{} = c1, %__MODULE__{} = c2), do: %__MODULE__{red: c1.red + c2.red, green: c1.green + c2.green, blue: c1.blue + c2.blue}

  @doc """
  Subtract colors.
  """
  @spec subtract(RayTracer.Color.t(), RayTracer.Color.t()) :: RayTracer.Color.t()
  def subtract(%__MODULE__{} = c1, %__MODULE__{} = c2), do: %__MODULE__{red: c1.red - c2.red, green: c1.green - c2.green, blue: c1.blue - c2.blue}

  @doc """
  Schur or Hadarmard or product of two colors.
  """
  @spec product(RayTracer.Color.t(), RayTracer.Color.t()) :: RayTracer.Color.t()
  def product(%__MODULE__{} = c1, %__MODULE__{} = c2), do: %__MODULE__{red: c1.red * c2.red, green: c1.green * c2.green, blue: c1.blue * c2.blue}

  @doc """
  Scalar product of a color.
  """
  @spec scalar_product(RayTracer.Color.t(), number) :: RayTracer.Color.t()
  def scalar_product(%__MODULE__{} = c, scale), do: %__MODULE__{red: c.red * scale, green: c.green * scale, blue: c.blue * scale}

  @doc """
  Scale color between 0 and 255.
  """
  @spec color_scale_0_255(RayTracer.Color.t()) :: RayTracer.Color.t()
  def color_scale_0_255(%__MODULE__{} = c), do:
    %__MODULE__{red: Helper.scale_0_255(c.red), green: Helper.scale_0_255(c.green), blue: Helper.scale_0_255(c.blue)}

  @doc """
  Cast color to string.
  """
  @spec to_string(RayTracer.Color.t()) :: <<_::16, _::_*8>>
  def to_string(%__MODULE__{} = c), do: "#{c.red |> round |> Integer.to_string} #{c.green |> round |> Integer.to_string} #{c.blue |> round |> Integer.to_string} "
end

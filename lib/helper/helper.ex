defmodule Helper.Helper do
  @moduledoc """
  Helper functions.
  """
  @epsilon 0.00001
  @doc """
  Since floating point comparison can be unreliable we check equality with a delta.float()

  ## Examples
    iex> Helper.Helper.equal(1.0, 1.001)
    false
    iex> Helper.Helper.equal(1.0, 1.000001)
    true
  """
  @spec equal(float(), float()) :: boolean
  def equal(a, b), do: (a - b) |> abs < @epsilon

  @doc """
  Scale number between 0 and 255.

  ## Examples
    iex> Helper.Helper.scale_0_255(-1)
    0
    iex> Helper.Helper.scale_0_255(0.6)
    153.0
    iex> Helper.Helper.scale_0_255(1.5)
    255
  """
  @spec scale_0_255(number) :: number
  def scale_0_255(value) do
    (value * 255) |> _normalize_0_255
  end

  defp _normalize_0_255(value) when value < 0, do: 0
  defp _normalize_0_255(value) when value > 255, do: 255
  defp _normalize_0_255(value), do: value

  @doc """
  Write string to file.
  """
  def write_to(content, file_name) do
    File.write!(Path.absname("output/#{file_name}"), content, [:write])
  end
end

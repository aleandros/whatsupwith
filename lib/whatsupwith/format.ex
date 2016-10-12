defmodule Whatsupwith.Format do
  @moduledoc """
  Presentation layer for the program.

  Provides the necessary functions correctly building
  the program output.
  """

  @doc """
  Build a string in simple tabular fashion
  given a list of `Whatsupwith.Program` elements.
  """
  def tabular_format([]), do: ""
  def tabular_format(programs) do
    widths = column_widths(programs)
    programs
    |> Enum.map(&(format_row(&1, widths)))
    |> Enum.join("\n")
  end

  defp column_widths(programs) do
    maxlength_name = programs
    |> Enum.map(&(&1.name |> String.length))
    |> Enum.max
    maxlength_path = programs
    |> Enum.map(&(&1.path |> String.length))
    |> Enum.max
    {maxlength_name, maxlength_path}
  end

  defp format_row(program, {name_width, path_widht}) do
    [String.pad_trailing(program.name, name_width),
     String.pad_trailing(program.path, path_widht)]
     |> Enum.join(" ")
  end
end

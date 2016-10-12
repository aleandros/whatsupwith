defmodule Whatsupwith.FindExecutables do
  @moduledoc """
  Exposes and contains implementation
  for finding programs in a given directory.

  A program is a considered to be a regular
  file in which any of the number of its
  permissions is odd.
  """
  require Integer
  alias Whatsupwith.Program

  @doc """
  Given a directory, return
  a list of `Whatsupwith.Program` structs.

  In case of an error reading the directory,
  an empty list is returned.
  """
  def from_directory(dir) do
    case File.ls(dir) do
      {:ok, files} ->
        files
        |> Enum.map(fn name ->
          %Program{name: name, path: Path.join(dir, name)}
        end)
        |> Enum.filter(fn prog -> executable_file?(prog.path) end)
      _ -> []
    end
  end

  defp executable_file?(path) do
    case File.stat(path) do
      {:ok, stat} -> executable_file_mode?(stat.mode)
      _ -> false
    end
  end

  defp executable_file_mode?(mode) do
    mode
    |> mode_to_octals
    |> regular_exectutable?
  end

  defp mode_to_octals(mode) do
    [octal] = :io_lib.format("~.8B", [mode])
    {num, _} = octal |> to_string |> Integer.parse
    Integer.digits(num)
  end

  defp regular_exectutable?(octals) do
    regular?(octals) and executable?(octals)
  end

  defp regular?([type|_]), do: type == 1

  defp executable?([_, _, _, u, g, o]) do
    Enum.any?([u, g, o], &Integer.is_odd/1)
  end
end

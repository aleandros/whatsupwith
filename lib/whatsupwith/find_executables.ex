require Integer
alias Whatsupwith.Parallel

defmodule Whatsupwith.FindExecutables do
  def from_directory(dir) do
    case File.ls(dir) do
      {:ok, files} ->
        files
        |> Enum.map(&({Path.join(dir, &1), &1}))
        |> Enum.filter(fn {p, _} -> executable_file?(p) end)
      _ -> []
    end
  end

  defp executable_file?(path) do
    case File.stat(path) do
      {:ok, stat} -> executable_file_mode?(stat.mode)
      other -> false
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

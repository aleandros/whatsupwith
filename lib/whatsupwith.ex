defmodule Whatsupwith do
  @moduledoc """
  Logic for inspecting information about
  program names.
  """
  alias Whatsupwith.{FindExecutables, Format, Filter}

  @doc """
  Program entrypoint.

  Fetches the program list, handles relevant
  arguments and displays them in the appropriate
  format.
  """
  def main([]) do
    list_programs
    |> Format.tabular_format
    |> IO.puts
  end
  def main(argv) do
    case configuration(argv) do
      {[strategy: strategy, property: property], target} ->
        list_programs
        |> Filter.search(property, target, strategy)
        |> Format.tabular_format
        |> IO.puts
      _ -> IO.puts("Invalid options")
    end
  end

  @doc """
  Function in charge of fetching all program
  information fromAdd ta the PATH environment variable.
  """
  def list_programs do
    "PATH"
    |> System.get_env
    |> String.split(":")
    |> MapSet.new
    |> Enum.map(&FindExecutables.from_directory/1)
    |> Enum.concat
  end

  defp configuration(argv) do
    switches = [strategy: :string,
                property: :string]
    case OptionParser.parse(argv, switches: switches) do
      {parsed, remaining, []} -> handleparsed(parsed, remaining)
      _ -> :error
    end
  end

  defp handleparsed(_, []), do: :error
  defp handleparsed(parsed, [arg|_]) do
    strategy = parsed
    |> Keyword.get(:strategy, "substring")
    |> String.to_atom
    property = parsed
    |> Keyword.get(:property, "name")
    |> String.to_atom
    {[strategy: strategy, property: property], arg}
  end
end

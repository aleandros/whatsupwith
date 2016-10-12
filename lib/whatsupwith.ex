defmodule Whatsupwith do
  @moduledoc """
  Logic for inspecting information about
  program names.
  """
  alias Whatsupwith.{FindExecutables, Format}

  @doc """
  Program entrypoint.

  Fetches the program list, handles relevant
  arguments and displays them in the appropriate
  format.
  """
  def main(_args) do
    list_programs
    |> Format.tabular_format
    |> IO.puts
  end

  @doc """
  Function in charge of fetching all program
  information from the PATH environment variable.
  """
  def list_programs do
    System.get_env("PATH")
    |> String.split(":")
    |> MapSet.new
    |> Enum.map(&FindExecutables.from_directory/1)
    |> Enum.concat
  end
end

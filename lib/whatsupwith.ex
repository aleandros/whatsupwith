alias Whatsupwith.{FindExecutables, Program}

defmodule Whatsupwith do
  @moduledoc """
  Logic for inspecting information about
  program names.
  """
  def main(_args) do
    Enum.each(list_programs, &(IO.puts(Program.format(&1))))
  end

  def list_programs do
    System.get_env("PATH")
    |> String.split(":")
    |> MapSet.new
    |> Enum.map(&FindExecutables.from_directory/1)
    |> Enum.concat
  end
end

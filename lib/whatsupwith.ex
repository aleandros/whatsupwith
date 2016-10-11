alias Whatsupwith.{Parallel, FindExecutables}

defmodule Whatsupwith do
  @moduledoc """
  Logic for inspecting information about
  program names.
  """

  def list_programs do
    System.get_env("PATH")
    |> String.split(":")
    |> MapSet.new
    |> Parallel.map(&FindExecutables.from_directory/1)
    |> Enum.concat
  end
end

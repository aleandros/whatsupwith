defmodule Whatsupwith.Program do
  defstruct name: nil, path: nil

  def format(%Whatsupwith.Program{name: name, path: path}) do
    """
    #{name}
    Path: #{path}
    """
  end
end

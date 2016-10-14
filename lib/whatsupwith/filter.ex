defmodule Whatsupwith.Filter do
  @moduledoc """
  Provides funcionality for looking up
  programs given certains constraints.
  """
  import String, only: [contains?: 2]

  @doc """
  Given a list of `Whatsupwith.Program`s, return
  the elements that match the given criteria.

  It searches given a certain property of the `Program`
  struct, unsing any of the following strategies:

  * :exact -> Looks for an exact string match.
  * :substring -> The target must be contained inside the property.
  * :match -> Verifies that the properties matches the target regex.
  """
  def search(programs, property, target, strategy) do
    Enum.filter(programs, predicate(strategy, property, target))
  end

  defp predicate(:exact, property, string), do: test_fn(property, string, &==/2)
  defp predicate(:substring, property, sub), do: test_fn(property, sub, &contains?/2)
  defp predicate(:match, property, regex) do
    {:ok, compiled_regex} = Regex.compile(regex)
    test_fn(property, compiled_regex, fn(prop, target) ->
      Regex.match?(target, prop)
    end)
  end

  defp test_fn(property, target, lookup) do
    fn(program) ->
      %{^property => prop} = program
      lookup.(prop, target)
    end
  end
end

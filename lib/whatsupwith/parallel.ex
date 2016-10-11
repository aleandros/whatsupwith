defmodule Whatsupwith.Parallel do
  def map(collection, func) do
    collection
    |> Enum.map(&(Task.async(fn -> func.(&1) end)))
    |> Enum.map(&(Task.await/1))
  end

  def filter(collection, predicate) do
    map(collection, predicate)
    |> Enum.zip(collection)
    |> Enum.filter(fn {p, _} -> p end)
    |> Enum.map(fn {_, e} -> e end)
  end
end

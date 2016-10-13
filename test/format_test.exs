defmodule FormatTest do
  use ExUnit.Case
  alias Whatsupwith.{Format, Program}

  test "returns and empty string for no program data" do
    assert Format.tabular_format([]) == ""
  end

  test "separates every column by at least one space" do
    prog = %Program{name: "a", path: "/bin/a"}
    assert Format.tabular_format([prog]) == "a /bin/a"
  end

  test "rows are separated by new lines" do
    progs = [%Program{name: "a", path: "/bin/a"},
             %Program{name: "a", path: "/bin/a"}]
    expected = """
               a /bin/a
               a /bin/a
               """
    assert prepare(Format.tabular_format(progs)) == expected
  end

  test "column width is defined by the longest element" do
    progs = [%Program{name: "a", path: "/bin/a"},
             %Program{name: "a2", path: "/bin/a2"}]
    expected = """
               a  /bin/a
               a2 /bin/a2
               """
    assert prepare(Format.tabular_format(progs)) == expected
  end

  defp prepare(txt) do
    "#{txt}\n"
    |> String.split("\n")
    |> Enum.map(&String.trim_trailing/1)
    |> Enum.join("\n")
  end
end

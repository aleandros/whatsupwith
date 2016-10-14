defmodule FilterTest do
  use ExUnit.Case
  alias Whatsupwith.{Filter, Program}

  test "returns an empty list if the input is empty" do
    assert Filter.search([], :name, "a", :substring) == []
  end

  test "returns only programs whose property contains the target" do
    p1 = %Program{name: "ab", path: "/ab"}
    p2 = %Program{name: "c", path: "/wut"}
    assert Filter.search([p1, p2], :name, "a", :substring) == [p1]
    assert Filter.search([p1, p2], :path, "ut", :substring) == [p2]
  end

  test "returns only programs whose property matches the target exactly" do
    p1 = %Program{name: "ab", path: "/pathos"}
    p2 = %Program{name: "abc", path: "/path"}
    p3 = %Program{name: "?acb", path: "/dev/path"}
    ps = [p1, p2, p3]
    assert Filter.search(ps, :name, "ab", :exact) == [p1]
    assert Filter.search(ps, :path, "/path", :exact) == [p2]
  end

  test "returns only programs whose property matches the target as a regex" do
    p1 = %Program{name: "ab", path: "/pathos"}
    p2 = %Program{name: "abc", path: "/path"}
    p3 = %Program{name: "?acb", path: "/dev/path"}
    ps = [p1, p2, p3]
    assert Filter.search(ps, :name, "c$", :match) == [p2]
    assert Filter.search(ps, :path, "^\/path", :match) == [p1, p2]
  end
end

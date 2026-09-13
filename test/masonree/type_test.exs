defmodule Masonree.TypeTest do
  @moduledoc "Defines an `ExUnit.Case` case."
  @moduledoc since: "0.3.0"

  use ExUnit.Case, async: true

  alias Masonree

  alias Masonree.Type

  doctest Type, import: true

  @spec member?(module()) :: boolean()
  defp member?(module) do
    Code.ensure_loaded?(module) and Type in take_behaviours(module)
  end

  @spec take_behaviours(module()) :: [module()]
  defp take_behaviours(module) do
    :attributes
    |> module.__info__()
    |> Keyword.get_values(:behaviour)
    |> List.flatten()
  end

  describe "Type" do
    test "the lattice asks two questions, and every member must answer" do
      callbacks = Type.behaviour_info(:callbacks)

      assert Enum.sort(callbacks) == [admits?: 2, declarable?: 1]
    end
  end

  describe "admits?/2" do
    import Type, only: [admits?: 2]

    test "puts the question to the member" do
      assert admits?(:boolean, true)
      refute admits?(:boolean, "true")

      assert admits?(:number, 3)
      refute admits?(:number, "3")

      assert admits?(:string, "Hello, world!")
      refute admits?(:string, ~C"Hello, world!")

      assert admits?({:enum, ["dark", "light"]}, "dark")
      refute admits?({:enum, ["dark", "light"]}, "vermilion")
    end

    test "refuses a nil-payload tuple, which is not a type" do
      refute admits?({:boolean, nil}, true)
      refute admits?({:number, nil}, 3)
      refute admits?({:string, nil}, "Hello, world!")
    end

    test "refuses a type the lattice does not hold" do
      refute admits?(:bool, true)
      refute admits?({:bool, true}, true)
      refute admits?("boolean", true)
      refute admits?("boolean", "true")
    end

    test "returns true for a nil, whatever the type" do
      assert admits?(:boolean, nil)
      assert admits?(:bool, nil)
    end
  end

  describe "declarable?/1" do
    import Type, only: [declarable?: 1]

    test "puts the declaration to the member" do
      assert declarable?(:string)
      assert declarable?({:enum, []})
      refute declarable?({:string, []})
      refute declarable?({:enum, nil})
    end

    test "refuses a type the lattice does not hold" do
      refute declarable?(:bool)
      refute declarable?({:choice, []})
      refute declarable?("boolean")
    end

    test "refuses an explicit nil payload, which the bare form is not" do
      refute declarable?({:boolean, nil})
      refute declarable?({:number, nil})
      refute declarable?({:string, nil})
    end
  end

  describe "list_tags/0" do
    import Type, only: [list_tags: 0]

    test "answers one tag for every member the library compiles, sorted" do
      {:ok, modules} = :application.get_key(:cavalree, :modules)

      tags =
        for module <- modules, member?(module) do
          module
          |> Module.split()
          |> List.last()
          |> String.downcase()
          |> String.to_existing_atom()
        end

      assert list_tags() == Enum.sort(tags)
    end
  end
end

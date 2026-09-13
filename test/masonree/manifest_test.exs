defmodule Masonree.ManifestTest do
  @moduledoc "Defines an `ExUnit.Case` case."
  @moduledoc since: "0.3.0"

  use ExUnit.Case, async: true

  alias Masonree

  alias Masonree.Manifest

  alias Manifest.Attribute

  doctest Manifest, import: true

  describe "%Manifest{}" do
    test "carries a declared attribute" do
      manifest = %Manifest{
        attributes: %{
          "content" => attribute = %Attribute{default: "", type: :string}
        },
        name: "test/example",
        version: 1
      }

      assert manifest.attributes["content"] == attribute
    end

    test "defaults every field it does not enforce to nothing" do
      manifest = %Manifest{name: "test/example", version: 1}

      for %{field: field, required: false} <- Manifest.__info__(:struct) do
        assert Map.fetch!(manifest, field) in [%{}, [], nil]
      end
    end

    test "enforces a name and a version" do
      message = ~r"must also be given .*: \[:name, :version\]"

      assert_raise ArgumentError, message, fn -> struct!(Manifest, []) end
    end
  end

  describe "get_namespace/1" do
    import Manifest, only: [get_namespace: 1]

    test "answers nil for a name with no separator to split" do
      assert get_namespace("example") == nil
    end

    test "answers nil when a second separator makes the name ambiguous" do
      assert get_namespace("test/example/extra") == nil
    end

    test "answers nil when either half of the name is empty" do
      assert get_namespace("/example") == nil
      assert get_namespace("test/") == nil
    end

    test "takes the owning half of a namespaced name" do
      assert get_namespace("core/paragraph") == "core"
    end
  end
end

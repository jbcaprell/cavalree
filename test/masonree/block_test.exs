defmodule Masonree.BlockTest do
  @moduledoc "Defines an `ExUnit.Case` case."
  @moduledoc since: "0.3.0"

  use ExUnit.Case, async: true

  alias Masonree

  alias Masonree.Block

  doctest Block, import: true

  describe "Block" do
    test "asks every block for a manifest" do
      assert Block.behaviour_info(:callbacks) == [manifest: 0]
      assert Block.behaviour_info(:optional_callbacks) == []
    end
  end
end

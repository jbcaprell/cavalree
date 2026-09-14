defmodule Masonree.Block.SectionTest do
  @moduledoc "Defines an `ExUnit.Case` case."
  @moduledoc since: "0.6.0"

  use ExUnit.Case, async: true

  alias Masonree

  alias Masonree.Block
  alias Masonree.Manifest

  alias Manifest.Containment
  alias Manifest.Template

  describe "manifest/0" do
    import Block.Section, only: [manifest: 0]

    test "returns the declaration whole" do
      assert manifest() == %Manifest{
               category: "layout",
               containment: %Containment{
                 templates: [
                   %Template{label: "Paragraph", type: "core/paragraph"}
                 ]
               },
               label: "Section",
               name: "core/section",
               version: 1
             }
    end
  end
end

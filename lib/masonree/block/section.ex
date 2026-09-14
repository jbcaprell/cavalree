defmodule Masonree.Block.Section do
  @moduledoc """
  Defines a block.

  A section: a container and nothing more. It holds whatever blocks an author
  puts inside it, declaring no attribute of its own — what a section looks like
  is a stylesheet’s business, and what it means is the author’s.

  The containment names no `allowed` list and sets no floor. Any block may go
  inside, another section included, and a section holding nothing is odd on a
  page but not wrong, so nothing refuses it. The one template is what a fresh
  section starts as, not what it must keep: a paragraph to write into, which an
  author may remove and still have a section.
  """
  @moduledoc since: "0.6.0"

  use Masonree.Block

  alias Manifest.Containment
  alias Manifest.Template

  @manifest %Manifest{
    category: "layout",
    containment: %Containment{
      templates: [%Template{label: "Paragraph", type: "core/paragraph"}]
    },
    label: "Section",
    name: "core/section",
    version: 1
  }
end

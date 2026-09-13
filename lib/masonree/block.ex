defmodule Masonree.Block do
  @moduledoc """
  Defines what a block must answer.

  A block is a module rather than a row: a manifest declaring what it is, and —
  where it has markup — a render function projecting one of its nodes into that
  markup. Both are code, fixed when the library compiles, so no question about
  a block needs a database to answer it.

  Only `c:manifest/0` is mandatory. A block that never renders is legal and
  useful: the manifest is the whole of what a block declares, so anything that
  only has to know what a block is can be answered before a line of markup
  exists, and a block whose markup has not been written yet is a block whose
  contract already holds.

  `c:render/1` receives assigns and returns markup paired with whatever the
  block wants said about its own content. `assigns()` names every key a block
  may read, so a block cannot come to depend on something a caller happened to
  include. A report is a bare `term()`, because a block says what it found and
  something else decides what that is worth.
  """
  @moduledoc since: "0.3.0"

  alias Masonree
  alias Phoenix

  alias Masonree.Manifest
  alias Masonree.Node
  alias Phoenix.HTML
  alias Phoenix.LiveView

  alias LiveView.Rendered

  @typedoc "Represents everything a block may read, closed at four keys."
  @typedoc since: "0.3.0"
  @type assigns() :: %{
          __changed__: nil,
          html_attributes: [{String.t(), String.t()}],
          inner_block: [slot()],
          node: Node.t()
        }

  @typedoc "Represents the manifest."
  @typedoc since: "0.3.0"
  @type manifest() :: Manifest.t()

  @typedoc "Represents the markup and everything the block wants said."
  @typedoc since: "0.3.0"
  @type projection() :: {Rendered.t(), [term()]}

  @typedoc "Represents a block’s interior, already rendered, as HEEx takes it."
  @typedoc since: "0.3.0"
  @type slot() :: %{
          __slot__: :inner_block,
          inner_block: (term(), map() -> HTML.safe())
        }

  @doc "Returns the block’s manifest."
  @doc since: "0.3.0"
  @callback manifest() :: manifest()

  @doc "Projects a node into markup for `assigns`."
  @doc since: "0.3.0"
  @callback render(assigns()) :: projection()

  @optional_callbacks render: 1
end

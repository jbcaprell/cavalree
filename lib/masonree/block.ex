defmodule Masonree.Block do
  @moduledoc """
  Defines what a block must answer.

  A block is a module rather than a row: a manifest declaring what it is, fixed
  when the library compiles, so no question about a block needs a database to
  answer it.

  A block answers `c:manifest/0`, and nothing else is asked of it. The manifest
  is the whole of what a block says about itself, so a question about what a
  block is never has to reach for anything the block might also do.
  """
  @moduledoc since: "0.3.0"

  alias Masonree

  alias Masonree.Manifest

  @typedoc "Represents the manifest."
  @typedoc since: "0.3.0"
  @type manifest() :: Manifest.t()

  @doc "Returns the block’s manifest."
  @doc since: "0.3.0"
  @callback manifest() :: manifest()
end

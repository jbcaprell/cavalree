defmodule Masonree.Manifest do
  @moduledoc """
  Defines what a block declares about itself.

  A manifest is the whole of what a block knows about itself: anything needing a
  second block to answer belongs elsewhere, which is what lets a manifest be
  checked at its own compile.
  """
  @moduledoc since: "0.3.0"
end

defmodule Masonree.Type.Number do
  @moduledoc "Defines the `:number` member of the lattice."
  @moduledoc since: "0.3.0"

  @behaviour Masonree.Type

  alias Masonree

  alias Masonree.Type

  @impl Type
  def admits?(_payload, value), do: is_number(value)
end

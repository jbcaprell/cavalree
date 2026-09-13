defmodule Masonree.Type.Enum do
  @moduledoc "Defines the `{:enum, values}` member of the lattice."
  @moduledoc since: "0.3.0"

  @behaviour Masonree.Type

  alias Masonree

  alias Masonree.Type

  @impl Type
  def admits?(payload, value) when is_list(payload), do: value in payload
  def admits?(_payload, _value), do: false

  @impl Type
  def declarable?(payload), do: is_list(payload)
end

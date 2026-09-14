defmodule Masonree.Type.Number do
  @moduledoc "Defines the `:number` member of the lattice."
  @moduledoc since: "0.3.0"

  @behaviour Masonree.Type

  alias Masonree

  alias Masonree.Type

  @typep default() :: Type.default()
  @typep healing() :: Type.healing()
  @typep payload() :: Type.payload()
  @typep value() :: Type.value()

  # @impl Type
  @doc "Returns the repair of `value` toward `default`, given `payload`."
  @spec heal(payload(), value(), default()) :: healing()
  def heal(_payload, _value, _default), do: :refused

  @impl Type
  def admits?(_payload, value), do: is_number(value)

  @impl Type
  def declarable?(payload), do: is_nil(payload)
end

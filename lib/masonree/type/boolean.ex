defmodule Masonree.Type.Boolean do
  @moduledoc """
  Defines the `:boolean` member of the lattice.

  A flag, and nothing else: `true` or `false`, never `"true"`, and never `1`. A
  type that admitted a string here would make every reader of a stored value
  guess which spelling produced it.
  """
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
  def admits?(_payload, value), do: is_boolean(value)

  @impl Type
  def declarable?(payload), do: is_nil(payload)
end

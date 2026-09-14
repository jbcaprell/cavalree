defmodule Masonree.Type.Enum do
  @moduledoc "Defines the `{:enum, values}` member of the lattice."
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
  def heal(_payload, _value, default), do: {:coerced, default}

  @impl Type
  def admits?(payload, value) when is_list(payload), do: value in payload
  def admits?(_payload, _value), do: false

  @impl Type
  def declarable?(payload), do: is_list(payload)
end

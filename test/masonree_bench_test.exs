defmodule MasonreeBenchTest do
  @moduledoc "Defines an `ExUnit.Case` case."
  @moduledoc since: "0.4.0"

  use ExUnit.Case, async: true

  alias MasonreeBench

  doctest MasonreeBench, import: true
end

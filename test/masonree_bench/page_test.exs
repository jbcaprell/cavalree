defmodule MasonreeBench.PageTest do
  @moduledoc "Defines an `ExUnit.Case` case."
  @moduledoc since: "0.4.0"

  use ExUnit.Case, async: true

  alias MasonreeBench

  alias MasonreeBench.Page

  doctest Page, import: true
end

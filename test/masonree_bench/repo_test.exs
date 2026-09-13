defmodule MasonreeBench.RepoTest do
  @moduledoc "Defines an `ExUnit.Case` case."
  @moduledoc since: "0.4.0"

  use ExUnit.Case, async: true

  alias MasonreeBench

  alias MasonreeBench.Repo

  doctest Repo, import: true
end

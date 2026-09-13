defmodule MasonreeBench.RepoTest do
  @moduledoc "Defines an `ExUnit.Case` case."
  @moduledoc since: "0.4.0"

  use ExUnit.Case, async: true

  alias MasonreeBench

  alias MasonreeBench.Repo

  describe "Repo" do
    test "declares itself an Ecto.Repo, so a test may reach a real column" do
      attributes = Repo.__info__(:attributes)

      assert attributes[:behaviour] == [Ecto.Repo]
    end
  end
end

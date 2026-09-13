defmodule MasonreeBench.RepoTest do
  @moduledoc "Defines an `ExUnit.Case` case."
  @moduledoc since: "0.4.0"

  use ExUnit.Case, async: false

  alias Ecto
  alias MasonreeBench

  alias Ecto.Adapters
  alias MasonreeBench.Repo

  alias Adapters.SQL

  alias SQL.Sandbox

  describe "Repo" do
    test "declares itself an Ecto.Repo, so a test may reach a real column" do
      attributes = Repo.__info__(:attributes)

      assert attributes[:behaviour] == [Ecto.Repo]
    end
  end

  describe "init/2" do
    import Repo, only: [init: 2]

    test "answers the same for a supervisor as for a runtime caller" do
      assert init(:supervisor, []) == init(:runtime, [])
    end

    test "keeps the sandbox pool, so a test sees none of another’s rows" do
      {:ok, configuration} = init(:runtime, [])

      assert configuration[:pool] == Sandbox
    end

    test "keeps what Ecto supplies and wins where the two disagree" do
      supplied = [otp_app: :cavalree, pool_size: 10, timeout: 15_000]

      {:ok, configuration} = init(:runtime, supplied)

      assert configuration[:otp_app] == :cavalree
      assert configuration[:timeout] == 15_000
      assert configuration[:pool_size] == System.schedulers_online() * 2
    end

    test "reads every connection value from the environment" do
      clear = fn ->
        System.delete_env("MASONREE_BENCH_DATABASE")
        System.delete_env("MASONREE_BENCH_PORT")
      end

      on_exit(clear)

      System.put_env("MASONREE_BENCH_DATABASE", "bench_probe")
      System.put_env("MASONREE_BENCH_PORT", "5555")

      {:ok, configuration} = init(:runtime, [])

      assert configuration[:database] == "bench_probe"
      assert configuration[:port] == 5_555
    end

    test "silences the log, so the gate prints a count and not SQL" do
      {:ok, configuration} = init(:runtime, [])

      refute configuration[:log]
    end

    test "takes the environment’s defaults when nothing overrides them" do
      {:ok, configuration} = init(:runtime, [])

      assert configuration[:database] == "masonree_bench"
      assert configuration[:hostname] == "localhost"
      assert configuration[:port] == 5_432
    end
  end
end

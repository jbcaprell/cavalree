defmodule MasonreeBench.Repo do
  @moduledoc """
  Defines the `Ecto.Repo` the suite reads and writes documents through.

  Postgres is the adapter because the claim under measurement is about `jsonb`.
  `Masonree.Envelope` hands an adapter a map and lets the column decide what
  that becomes, so a suite that measured any other column would be measuring a
  serialisation of the claim rather than the claim.

  `otp_app: :cavalree` is where a repo reads its connection from, and this
  project writes nothing there: it has no `config/` directory, and a database
  used by one suite does not earn one.
  """
  @moduledoc since: "0.4.0"

  use Ecto.Repo, adapter: Ecto.Adapters.Postgres, otp_app: :cavalree
end

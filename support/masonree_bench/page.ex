defmodule MasonreeBench.Page do
  @moduledoc """
  Defines the row a document is stored in.

  The library claims a document survives a database, and nothing in `Masonree`
  can put one there. This is the row that lets the claim be tested — somewhere a
  real document can be written to and read back from, so that the round trip is
  performed by Ecto and Postgres rather than by a test calling four functions in
  order and checking their arithmetic.
  """
  @moduledoc since: "0.4.0"
end

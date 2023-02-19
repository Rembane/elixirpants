defmodule Elixirpants.Repo do
  use Ecto.Repo,
    otp_app: :elixirpants,
    adapter: Ecto.Adapters.SQLite3
end

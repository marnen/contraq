# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Contraq.Repo.insert!(%Contraq.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# Recommended by Coherence:
#
# Contraq.Repo.delete_all Contraq.Coherence.User
#
# Contraq.Coherence.User.changeset(%Contraq.Coherence.User{}, %{name: "Test User", email: "testuser@example.com", password: "secret", password_confirmation: "secret"})
# |> Contraq.Repo.insert!

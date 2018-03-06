defmodule Contraq.Repo.Migrations.RenameGigsTimestamp do
  use Ecto.Migration

  def change do
    rename table(:gigs), :created_at, to: :inserted_at
  end
end

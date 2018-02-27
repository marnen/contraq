defmodule Contraq.Repo.Migrations.CreateCoherenceUser do
  use Ecto.Migration
  def change do
    create table(:users) do

      add :name, :string
      add :email, :string
      # trackable
      add :sign_in_count, :integer, default: 0
      add :current_sign_in_at, :utc_datetime
      add :last_sign_in_at, :utc_datetime
      add :current_sign_in_ip, :string
      add :last_sign_in_ip, :string
      # rememberable
      add :remember_created_at, :utc_datetime
      # recoverable
      add :reset_password_token, :string
      add :reset_password_sent_at, :utc_datetime
      # authenticatable
      add :password_hash, :string
      
      timestamps()
    end
    create unique_index(:users, [:email])

  end
end

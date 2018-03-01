defmodule Contraq.Repo.Migrations.CreateCoherenceUser do
  use Ecto.Migration
  def change do
    users = table(:users)
    rename users, :encrypted_password, to: :password_hash
    rename users, :created_at, to: :inserted_at

    alter users do
      modify :current_sign_in_ip, :string
      modify :last_sign_in_ip, :string
    end
  end
end

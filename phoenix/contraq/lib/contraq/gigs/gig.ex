defmodule Contraq.Gigs.Gig do
  use Ecto.Schema
  import Ecto.Changeset
  alias Contraq.Coherence.User
  alias Contraq.Repo
  alias Ecto.Changeset


  schema "gigs" do
    belongs_to :user, Contraq.Coherence.User
    field :name, :string
    field :start_time, Timex.Ecto.DateTime
    field :end_time, Timex.Ecto.DateTime
    field :venue, :string
    field :street, :string
    field :city, :string
    field :state, :string, size: 2
    field :zip, :string
    # TODO: re-enable these when we implement these features.
    # field :amount_due, :decimal, precision: 8, scale: 2
    # field :terms, :integer

    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = gig, attrs) do
    gig
    |> Repo.preload(:user) # TODO: required for dealing with the user, but do we always need to do that?
    |> cast(attrs, [:name, :start_time, :end_time, :venue, :street, :city, :state, :zip]) # , :amount_due, :terms])
    |> save_user
    |> validate_required([:name, :start_time, :end_time])
    |> foreign_key_constraint(:user_id)
  end

  @spec save_user(Changeset.t) :: Changeset.t
  defp save_user(%Changeset{params: params} = changeset) do
    case user = params["user"] do
      %User{} -> changeset |> put_assoc(:user, user)
      _ -> changeset |> cast_assoc(:user, required: true)
    end
  end
end

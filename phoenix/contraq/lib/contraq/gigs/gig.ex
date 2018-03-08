defmodule Contraq.Gigs.Gig do
  use Ecto.Schema
  import Ecto.Changeset


  schema "gigs" do
    belongs_to :user, Contraq.Coherence.User
    field :name, :string
    field :start_time, :naive_datetime
    field :end_time, :naive_datetime
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
    |> cast(attrs, [:name, :start_time, :end_time, :venue, :street, :city, :state, :zip]) # , :amount_due, :terms])
    |> validate_required([:name, :start_time, :end_time])
  end
end

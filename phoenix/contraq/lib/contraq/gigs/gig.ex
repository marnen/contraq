defmodule Contraq.Gigs.Gig do
  use Ecto.Schema
  import Ecto.Changeset
  alias Contraq.Gigs.Gig


  schema "gigs" do
    field :amount_due, :decimal, precision: 8, scale: 2
    field :city, :string
    field :end_time, :naive_datetime
    field :name, :string
    field :start_time, :naive_datetime
    field :state, :string, size: 2
    field :street, :string
    field :terms, :integer
    field :venue, :string
    field :zip, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Gig{} = gig, attrs) do
    gig
    |> cast(attrs, [:name, :start_time, :end_time, :venue, :street, :city, :state, :zip, :amount_due, :terms])
    |> validate_required([:name, :start_time, :end_time, :venue, :street, :city, :state, :zip, :amount_due, :terms])
  end
end

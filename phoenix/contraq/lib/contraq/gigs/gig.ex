defmodule Contraq.Gigs.Gig do
  use ContraqWeb, :model
  alias Contraq.Gigs.Gig


  schema "gigs" do
    field :user_id, :id
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
  def changeset(%Gig{} = gig, attrs) do
    gig
    |> cast(attrs, [:name, :start_time, :end_time, :venue, :street, :city, :state, :zip]) # , :amount_due, :terms])
    |> validate_required([:name, :start_time, :end_time, :venue, :street, :city, :state, :zip, :amount_due, :terms])
  end
end

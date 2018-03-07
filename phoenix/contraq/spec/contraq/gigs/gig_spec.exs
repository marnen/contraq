defmodule Gigs.GigSpec do
  alias Contraq.Factory
  alias Contraq.Gigs.Gig
  use ESpec.Phoenix, model: Gig, async: true
  import Map, only: [delete: 2]

  context "validations" do
    let :valid_attributes, do: Map.from_struct(Factory.build :gig)
    let :valid_changeset, do: Gig.changeset(%Gig{}, valid_attributes)

    it "is valid with valid attributes" do
      assert valid_changeset.valid?
    end

    for {field, label} <- %{name: "a name", start_time: "a start time", end_time: "an end time"} do
      it "requires a #{label}" do
        attributes = valid_attributes |> delete(unquote field)
        refute Gig.changeset(%Gig{}, attributes).valid?
      end
    end
  end
end

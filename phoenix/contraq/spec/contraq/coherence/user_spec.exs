defmodule Coherence.UserSpec do
  alias Contraq.Coherence.User
  alias Contraq.Gigs.Gig
  alias Ecto.Association.Has
  use ESpec.Phoenix, model: User, async: true

  context "associations" do
    it "has many gigs" do
      expect User.__schema__(:association, :gigs) |> to(match_pattern %Has{cardinality: :many, queryable: Gig})
    end
  end
end

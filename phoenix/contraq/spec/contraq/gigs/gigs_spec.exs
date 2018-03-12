defmodule Contraq.GigsSpec do
  use ESpec
  alias Contraq.Factory
  alias Contraq.Gigs
  alias Contraq.Gigs.Gig
  alias Contraq.Repo
  import Faker.Util, only: [pick: 1]

  context "authorization" do
    it "uses Bodyguard" do
      import Enum, only: [member?: 2]
      assert Gigs.__info__(:attributes)[:behaviour] |> member?(Bodyguard.Policy)
    end

    context ":edit" do
      import Bodyguard, only: [permit: 4]
      let :action, do: :edit
      let :user, do: Factory.insert! :user
      subject do: permit described_module, action, user, gig

      context "user owns gig" do
        let :gig, do: Factory.insert! :gig, %{user: user}
        it do: is_expected.to eq :ok
      end

      context "user does not own gig" do
        let :gig, do: Factory.insert! :gig
        it do: is_expected.to be_error_result
      end
    end
  end

  context "retrieving gigs" do
    let :gigs_count, do: :rand.uniform 10
    let :gigs, do: (for _ <- 1..gigs_count, do: Factory.insert! :gig)

    describe "#list_gigs" do
      it "returns all gigs", pending: true do
        # TODO: pending because we've implemented some user scoping that breaks this.
        expect(Gigs.list_gigs).to eq gigs
      end
    end

    describe "#get_gig!" do
      context "ID of existing gig" do
        it "returns the gig with the given ID" do
          id = (gigs |> pick).id
          expect(Gigs.get_gig! id).to eq Repo.get!(Gig, id)
        end
      end

      context "nonexistent ID" do
        it "raises Ecto.NoResultsError" do
          id = Enum.max(for gig <- gigs, do: gig.id) + 1
          expect(fn -> Gigs.get_gig! id end).to raise_exception Ecto.NoResultsError
        end
      end
    end
  end

  context "modifying gigs" do
    before valid: Factory.attributes(:gig, required_only: true)
    let :valid, do: shared.valid
    let :invalid, do: %{name: nil}
    let :expected_attributes, do: valid |> Map.delete(:user)

    describe "#create_gig" do
      context "valid data" do
        it "creates a gig" do
          {:ok, gig} = Gigs.create_gig valid
          actual_attributes = Map.from_struct gig
          for pair <- expected_attributes do
            expect(actual_attributes).to have [pair]
          end
        end
      end

      context "invalid data" do
        it "returns an error changeset" do
          assert {:error, %Ecto.Changeset{}} = Gigs.create_gig invalid
        end
      end
    end

    describe "#update_gig" do
      let :valid, do: Map.delete shared.valid, :user
      let :gig, do: Factory.insert! :gig

      context "valid data" do
        it "updates the gig with the given attributes" do
          {:ok, new_gig} = Gigs.update_gig gig, valid
          actual_attributes = Map.from_struct new_gig
          for pair <- expected_attributes do
            expect(actual_attributes).to have [pair]
          end
        end
      end

      context "invalid data" do
        it "returns an error changeset" do
          assert {:error, %Ecto.Changeset{}} = Gigs.update_gig gig, invalid
        end
      end
    end
  end

  describe "#change_gig" do
    it "returns a changeset for the gig" do
      gig = Factory.insert! :gig
      assert %Ecto.Changeset{} = Gigs.change_gig(gig)
    end
  end

  describe "#delete_gig" do
    let :deleted_gig, do: Factory.insert! :gig
    let! :other_gig, do: Factory.insert! :gig
    let! :result, do: Gigs.delete_gig deleted_gig

    it "returns :ok and the deleted gig" do
      result = result()
      id = deleted_gig.id
      assert {:ok, %Gig{id: id}} = result
    end

    it "deletes the gig" do
      expect(fn -> Gigs.get_gig! deleted_gig.id end).to raise_exception Ecto.NoResultsError
    end

    it "does not delete other gigs" do
      expect(Gigs.get_gig!(other_gig.id).name).to eq other_gig.name
    end
  end
end

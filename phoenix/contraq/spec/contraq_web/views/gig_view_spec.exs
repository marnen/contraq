defmodule ContraqWeb.GigViewSpec do
  use ESpec.Phoenix, async: true, view: ContraqWeb.GigView
  alias Contraq.Factory

  let :attributes, do: %{}
  let :gig, do: Factory.build(:gig, attributes)

  describe ".location" do
    subject do: described_module.location gig

    context "city and state present" do
      it "returns the city and state, joined with a comma" do
        expect(subject).to eq "#{gig.city}, #{gig.state}"
      end
    end

    context "city not present" do
      let :attributes, do: %{city: nil}

      it "returns the state" do
        expect(subject).to eq gig.state
      end
    end

    context "state not present" do
      let :attributes, do: %{state: nil}

      it "returns the city" do
        expect(subject).to eq gig.city
      end
    end

    context "no location" do
      let :attributes, do: %{city: nil, state: nil}

      it "returns an empty string" do
        expect(subject).to eq ""
      end
    end
  end

  describe ".time_range" do
    subject do: described_module.time_range gig

    it "returns the starting and ending times for the gig, formatted and joined with an en-dash" do
      formatted_times = for time <- [gig.start_time, gig.end_time] do
        Timex.format! time, Application.get_env(:contraq, ContraqWeb)[:datetime_format]
      end
      expect(subject).to eq Enum.join(formatted_times, "–")
    end
  end
end

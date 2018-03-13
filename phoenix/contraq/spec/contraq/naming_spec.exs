defmodule Contraq.NamingSpec do
  use ESpec, async: true
  alias Contraq.Naming

  describe "#dasherize" do
    context "string has no underscores" do
      it "returns the string" do
        string = Faker.Lorem.sentence
        expect(Naming.dasherize string).to eq string
      end
    end

    context "string has underscores" do
      it "returns the string with the underscores changed to dashes" do
        import Enum, only: [join: 2]
        words = Faker.Lorem.words
        string = words |> join("_")
        expect(Naming.dasherize string).to eq words |> join("-")
      end
    end
  end
end

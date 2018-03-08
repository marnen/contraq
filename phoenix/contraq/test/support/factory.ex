defmodule Contraq.Factory do
  # Cribbed from http://blog.plataformatec.com.br/wp-content/uploads/2016/12/whats-new-in-ecto-2-0-1.pdf#page=39

  alias Contraq.Repo

  @tags %{
    gig: Contraq.Gigs.Gig,
    user: Contraq.Coherence.User
  }

  defp base(:gig) do
    %{
      name: Faker.Lorem.sentence,
      start_time: Timex.to_datetime(Faker.Date.forward(100)), # TODO: randomize the time too?
      end_time: &(Timex.shift &1[:start_time], minutes: :rand.uniform(4*60)),
      user: fn _ -> build :user end
    }
  end

  defp base(:user) do
    %{
      email: Faker.Internet.email,
      password: Faker.Lorem.sentence,
      password_confirmation: &(&1[:password])
    }
  end

  def build(factory_name, attributes \\ %{}) do
    base = base(factory_name)
    merged_attributes = Map.merge(base, attributes)
    expanded_attributes = for {key, value} <- merged_attributes, into: %{} do
      new_value = if is_function(value), do: value.(merged_attributes), else: value
      {key, new_value}
    end
    struct Map.fetch!(@tags, factory_name), expanded_attributes
  end

  def insert!(factory_name, attributes \\ []) do
    attributes_map = attributes |> Enum.into(%{})
    record = build(factory_name, attributes_map)
    tag = record.__struct__
    Repo.insert! tag.changeset(struct(tag), Map.from_struct record)
  end
end

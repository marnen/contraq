defmodule Contraq.Factory do
  # Cribbed from http://blog.plataformatec.com.br/wp-content/uploads/2016/12/whats-new-in-ecto-2-0-1.pdf#page=39

  alias Contraq.Repo
  alias Contraq.Coherence.User
  import Phoenix.Naming, only: [camelize: 1]

  def build(:user) do
    %{
      email: Faker.Internet.email,
      password: Faker.Lorem.sentence,
      password_confirmation: &(&1[:password])
    }
  end

  def build(factory_name, attributes) do
    base = build(factory_name)
    merged_attributes = Map.merge(base, attributes)
    expanded_attributes = for {key, value} <- merged_attributes, into: %{} do
      new_value = if is_function(value), do: value.(merged_attributes), else: value
      {key, new_value}
    end
    {tag, _} = Code.eval_string(factory_name |> to_string |> camelize, [], aliases: __ENV__.aliases) # TODO: isn't there a better way to do this?
    struct tag, expanded_attributes
  end

  def insert!(factory_name, attributes \\ []) do
    attributes_map = attributes |> Enum.into(%{})
    record = build(factory_name, attributes_map)
    tag = record.__struct__
    Repo.insert! tag.changeset(struct(tag), Map.from_struct record)
  end
end

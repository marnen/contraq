defmodule Contraq.Factory do
  # Cribbed from http://blog.plataformatec.com.br/wp-content/uploads/2016/12/whats-new-in-ecto-2-0-1.pdf#page=39

  @type factory :: atom

  alias Contraq.Repo

  @tags %{
    gig: Contraq.Gigs.Gig,
    user: Contraq.Coherence.User
  }
  @build_defaults [required_only: false]

  @spec base(factory, keyword) :: struct
  defp base(factory_name, opts \\ [])

  defp base(:gig, opts) do
    [required_only: required_only] = Keyword.merge @build_defaults, opts
    required = %{
      name: Faker.Lorem.sentence,
      start_time: Timex.to_datetime(Faker.Date.forward(100)), # TODO: randomize the time too?
      end_time: &(Timex.shift &1[:start_time], minutes: :rand.uniform(4*60)),
      user: fn _ -> build :user end
    }
    optional = %{
      city: Faker.Address.city,
      state: Faker.Address.state_abbr
    }
    if required_only, do: required, else: Map.merge optional, required
  end

  defp base(:user, opts) do
    [required_only: required_only] = Keyword.merge @build_defaults, opts
    required = %{
      email: Faker.Internet.email,
      password: Faker.Lorem.sentence,
      password_confirmation: &(&1[:password])
    }
    optional = %{}
    if required_only, do: required, else: Map.merge optional, required
  end

  @spec attributes(factory, map, keyword) :: map
  def attributes(factory_name, %{} = extra_attributes, opts) do
    base = base(factory_name, opts)
    merged_attributes = Map.merge(base, extra_attributes)
    for {key, value} <- merged_attributes, into: %{} do
      new_value = if is_function(value), do: value.(merged_attributes), else: value
      {key, new_value}
    end
  end

  @spec attributes(factory, keyword) :: map
  def attributes(factory_name, opts), do: attributes(factory_name, %{}, opts)

  @spec build(factory, map, keyword) :: struct
  def build(factory_name, %{} = extra_attributes, opts) do
    attributes = attributes(factory_name, extra_attributes, opts)
    struct Map.fetch!(@tags, factory_name), attributes
  end

  @spec build(factory, map) :: struct
  def build(factory_name, %{} = extra_attributes), do: build(factory_name, extra_attributes, [])

  @spec build(factory, keyword) :: struct
  def build(factory_name, opts), do: build(factory_name, %{}, opts)

  @spec build(factory) :: struct
  def build(factory_name), do: build(factory_name, %{}, [])

  @spec insert!(factory, map, keyword) :: struct
  def insert!(factory_name, %{} = extra_attributes, opts) do
    record = build(factory_name, extra_attributes, opts)
    tag = record.__struct__
    Repo.insert! tag.changeset(struct(tag), Map.from_struct record)
  end

  @spec insert!(factory, map) :: struct
  def insert!(factory_name, %{} = extra_attributes), do: insert!(factory_name, extra_attributes, [])

  @spec insert!(factory, keyword) :: struct
  def insert!(factory_name, opts), do: insert!(factory_name, %{}, opts)

  @spec insert!(factory) :: struct
  def insert!(factory_name), do: insert!(factory_name, %{}, [])
end

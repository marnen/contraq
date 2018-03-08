defmodule Contraq.Gigs do
  @moduledoc """
  The Gigs context.
  """

  import Ecto, only: [assoc: 2]
  import Ecto.Query, warn: false
  alias Contraq.Repo
  alias Contraq.Coherence.User
  alias Contraq.Gigs.Gig

  @doc """
  Returns the list of gigs.

  ## Examples

      iex> list_gigs()
      [%Gig{}, ...]

  """
  @spec list_gigs(user: %User{}) :: [%Gig{}]
  def list_gigs(user: user = %User{}) do
    Repo.all assoc(user, :gigs)
  end

  @doc """
  Gets a single gig.

  Raises `Ecto.NoResultsError` if the Gig does not exist.

  ## Examples

      iex> get_gig!(123)
      %Gig{}

      iex> get_gig!(456)
      ** (Ecto.NoResultsError)

  """
  def get_gig!(id), do: Repo.get!(Gig, id)

  @doc """
  Creates a gig.

  ## Examples

      iex> create_gig(%{field: value})
      {:ok, %Gig{}}

      iex> create_gig(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_gig(attrs \\ %{}) do
    %Gig{}
    |> Gig.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a gig.

  ## Examples

      iex> update_gig(gig, %{field: new_value})
      {:ok, %Gig{}}

      iex> update_gig(gig, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_gig(%Gig{} = gig, attrs) do
    gig
    |> Gig.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Gig.

  ## Examples

      iex> delete_gig(gig)
      {:ok, %Gig{}}

      iex> delete_gig(gig)
      {:error, %Ecto.Changeset{}}

  """
  def delete_gig(%Gig{} = gig) do
    Repo.delete(gig)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking gig changes.

  ## Examples

      iex> change_gig(gig)
      %Ecto.Changeset{source: %Gig{}}

  """
  def change_gig(%Gig{} = gig) do
    Gig.changeset(gig, %{})
  end
end

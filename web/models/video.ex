defmodule Rumbl.Video do
  use Rumbl.Web, :model

  schema "videos" do
    field :title, :string
    field :url, :string
    field :description, :string

    belongs_to :user, Rumbl.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :url, :description])
    |> validate_required([:title, :url, :description])
  end
end
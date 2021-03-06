defmodule Rumbl.Video do
  use Rumbl.Web, :model

  schema "videos" do
    field :title, :string
    field :url, :string
    field :description, :string

    belongs_to :user, Rumbl.User
    belongs_to :category, Rumbl.Category

    timestamps()
  end

  @required_fields ~w(url title description)
  @optional_fields ~w(category_id)

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
    |> validate_required([:title, :url, :description])
  end
end

defmodule Elixirgist.Gists.Gist do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "gist" do
    field :description, :string
    field :markup_text, :string
    field :name, :string
    # field :user_id, :binary_id
    belongs_to :user, Elixirgist.Accounts.User
    has_many :comments,Elixirgist.Comments.Comment

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(gist, attrs) do
    gist
    |> cast(attrs, [:name, :description, :markup_text])
    |> validate_required([:name, :description, :markup_text, :user_id])
  end
end

defmodule Chat.Schemas.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:user_id, :binary_id, autogenerate: true}
  schema "users" do

    field :name, :string
    field :avatar_url, :string
    field :status, :string
    field :last_seen_at, :utc_datetime_usec

  end

  def changeset(user, attrs) do

    user
    |> cast(attrs, [:name, :avatar_url, :status, :last_seen_at])
    |> validate_required([:name])

  end

end

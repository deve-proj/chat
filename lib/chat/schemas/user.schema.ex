defmodule Chat.Schemas.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true}
  schema "room_users" do

    field :room_id, :binary_id
    field :user_id, :binary_id
    field :user_name, :string
    timestamps()

  end

  def changeset(user, attrs) do

    user
    |> cast(attrs, [:room_id, :user_id, :user_name])
    |> validate_required([:room_id, :user_id, :user_name])

  end

end

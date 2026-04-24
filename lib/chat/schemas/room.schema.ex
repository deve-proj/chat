defmodule Chat.Schemas.Room do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "rooms" do

    field :room_name, :string
    field :owner_id, :binary_id
    field :logo_url, :string
    field :room_type, :string
    field :accessability, :string
    timestamps()

  end

  def changeset(room, attrs) do

    room
    |> cast(attrs, [:room_name, :owner_id, :logo_url, :room_type, :accessability])
    |> validate_required([:room_name, :owner_id])

  end

end

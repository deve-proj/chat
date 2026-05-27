defmodule Chat.Schemas.Room do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "rooms" do

    field :name, :string
    field :owner_id, :binary_id
    field :logo_url, :string
    field :type, :string
    field :accessability, :string
    field :members, {:array, :string}

    timestamps()

  end

  def changeset(room, attrs) do

    room
    |> cast(attrs, [:name, :owner_id, :logo_url, :type, :accessability, :members])
    |> validate_required([:name, :owner_id])

  end

end

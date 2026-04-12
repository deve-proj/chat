defmodule Chat.Schemas.Message do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :room_id, :user_id, :user_name, :body, :inserted_at]}

  schema "messages" do

    field :room_id, :binary_id
    field :user_id, :binary_id
    field :user_name, :string
    field :body, :string
    timestamps()

  end

  def changeset(message, attrs) do

    message
    |> cast(attrs, [:room_id, :user_id, :user_name, :body])
    |> validate_required([:room_id, :user_id, :user_name, :body])

  end

end

defmodule Chat do

  alias Chat.Repo
  alias Chat.Schemas.Room
  alias Chat.Schemas.User
  alias Chat.Schemas.Message
  import Ecto.Query


  def create_room(attrs) do

    %Room{}
    |> Room.changeset(attrs)
    |> Repo.insert()

  end

  def get_room!(id) do

    Repo.get!(Room, id)

  end

  def list_rooms do

    Repo.all(Room)

  end

  def list_rooms_by_user_id(user_id) do

    query = from u in Chat.Schemas.User,
      join: r in Chat.Schemas.Room,
      on: u.room_id == r.id,
      where: u.user_id == ^user_id,
      select: %{id: r.id, name: r.room_name}

    Repo.all(query)

  end

  def join_room(attrs) do

    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()

  end

  def new_message(attrs) do

    %Message{}
    |> Message.changeset(attrs)
    |> Repo.insert()

  end

  def get_messages_by_room_id(room_id, user_id) do

    query = from m in Chat.Schemas.Message,
      join: ru in Chat.Schemas.User,
      on: ru.room_id == m.room_id and ru.user_id == ^user_id,
      where: m.room_id == ^room_id,
      select: m

    Repo.all(query)

  end

  def get_users_by_room_id(room_id) do

    query = from u in Chat.Schemas.User, where: u.room_id == ^room_id, select: u

    Repo.all(query)

  end

end

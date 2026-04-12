defmodule ChatWeb.RoomController do
  use ChatWeb, :controller

  def get_rooms_by_user_id(conn, params) do

    rooms = Chat.list_rooms_by_user_id(params["user_id"])

    json(conn, %{rooms: rooms})

  end

  def get_messages_by_room_id(conn, params) do

    messages = Chat.get_messages_by_room_id(params["room_id"], params["user_id"])

    json(conn, %{messages: messages})

  end

end

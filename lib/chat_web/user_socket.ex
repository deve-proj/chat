defmodule ChatWeb.UserSocket do
  use Phoenix.Socket

  channel "room:*", ChatWeb.RoomChannel
  channel "post:*", ChatWeb.PostChannel

  def connect(params, socket, _connect_info) do

    IO.puts("Пытается подключиться...")

    user_id = params["user_id"]
    user_name = params["user_name"]

    socket = socket
      |> assign(:user_id, user_id)
      |> assign(:user_name, user_name)

    {:ok, socket}
  end

  def id(socket) do

    "user:#{socket.assigns.user_id}"

  end

end

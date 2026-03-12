defmodule ChatWeb.RoomChannel do
  use Phoenix.Channel

  def join("room:" <> room_name, _payload, socket) do

    user = socket.assigns.user_id

    case Chat.Room.join(room_name, user) do

      {:ok, users} ->

        socket = assign(socket, :room_name, room_name)

        {:ok, socket}


      {:error, reason} ->

        {:error, %{reason: "join failed: #{inspect(reason)}"}}

    end

  end

  def handle_in("new_message", %{"body" => body}, socket) do

    IO.puts("Handle some message...")

    room = socket.assigns.room_name
    user = socket.assigns.user_id

    Chat.Room.send_message(room, user, body)

    broadcast!(socket, "new_message", %{

      user: user,
      body: body,
      timestamp: DateTime.utc_now()

    })

    {:noreply, socket}

  end


end

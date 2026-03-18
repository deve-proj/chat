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

  @spec handle_in(<<_::88>>, map(), Phoenix.Socket.t()) :: {:noreply, Phoenix.Socket.t()}
  def handle_in("new_message", %{"body" => body}, socket) do

    IO.puts("Handle some message...")

    room = socket.assigns.room_name
    user_id = socket.assigns.user_id
    user_name = socket.assigns.user_name

    Chat.Room.send_message(room, user_id, user_name, body)

    broadcast!(socket, "new_message", %{

      user: user_id,
      body: "#{user_name} пишет: " <> body,
      timestamp: DateTime.utc_now()

    })

    {:noreply, socket}

  end


end

defmodule ChatWeb.PostChannel do
  use Phoenix.Channel

  def join("post:" <> post_id, _payload, socket) do

    user = socket.assigns.user_id

    case Chat.Post.join(post_id, user) do

      {:ok, users} ->

        socket = assign(socket, :post_id, post_id)

        {:ok, socket}

      {:error, reason} ->

        {:error, %{reason: "join failed: #{inspect(reason)}"}}

    end

  end

  @spec handle_in(<<_::88>>, map(), Phoenix.Socket.t()) :: {:noreply, Phoenix.Socket.t()}
  def handle_in("new_comment", %{"body" => body}, socket) do

    IO.puts("Heandle some message...")

    post_id = socket.assigns.post_id
    user_id = socket.assigns.user_id
    user_name = socket.assigns.user_name

    Chat.Post.send_comment(post_id, user_id, user_name, body) do

      broadcast!(socket, "new_comment", %{

        user: user_id,
        body: "#{user_name} пишет: " <> body,
        timestamp: DateTime.utc_now()

      })

      {:no_reply, socket}

    end

  end

end

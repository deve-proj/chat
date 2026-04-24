defmodule ChatWeb.PostChannel do
  use Phoenix.Channel

  def join("post:" <> post_id, _payload, socket) do

    case Registry.lookup(Chat.PostRegistry, post_id) do

      [{_pid, _}] ->

        {:ok, assign(socket, :post_id, post_id)}

      [] ->

        case Chat.Post.start_link(post_id) do

          {:ok, _pid} -> {:ok, assign(socket, :post_id, post_id)}
          {:error, _} -> {:error, %{reason: "cannot start post channel"}}

        end

    end

  end

  @spec handle_in(<<_::88>>, map(), Phoenix.Socket.t()) :: {:noreply, Phoenix.Socket.t()}
  @spec handle_in(<<_::88>>, map(), Phoenix.Socket.t()) :: :ok
  def handle_in("new_comment", %{"body" => body}, socket) do

    IO.puts("Heandle new comment...")

    post_id = socket.assigns.post_id
    user_id = socket.assigns.user_id

    Chat.Clients.News.send_comment(post_id, user_id, body)

    broadcast!(socket, "new_comment", %{

      user: user_id,
      text: body,
      timestamp: DateTime.utc_now()

    })

    {:noreply, socket}

  end

end

defmodule Chat.Clients.News do

  def send_comment(post_id, user_id, comment_body) do

    case Req.post("http://localhost:8000/news/comment", json: %{
      user_id: user_id,
      post_id: post_id,
      text: comment_body
    }) do

      {:ok, %{status: 200}} -> {:ok}
      {:error, reason} -> {:error, reason}

    end

  end

end

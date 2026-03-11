defmodule ChatWeb.TestController do
  use ChatWeb, :controller

  def test(conn, _params) do

    html(conn, "<p>ХУЙ</p>")

  end

end

defmodule Chat.Application do
  @moduledoc false
  use Application

  @impl true
  def start(_type, _args) do

    children = [

      {Registry, keys: :unique, name: Chat.RoomRegistry},
      {Phoenix.PubSub, name: Chat.PubSub},

      ChatWeb.Endpoint

    ]

    opts = [strategy: :one_for_one, name: Chat.Supervisor]
    Supervisor.start_link(children, opts)

  end

  @impl true
  def config_change(changed, new, removed) do

    ChatWeb.Endpoint.config_change(changed, removed)
    :ok

  end


end

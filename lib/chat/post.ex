defmodule Chat.Post do
  use GenServer

  def start_link(post_id) do

    GenServer.start_link(__MODULE__, [], name: via_tuple(post_id))

  end

  @spec join(any(), any()) :: any()
  def join(post_id, user) do

    GenServer.call(via_tuple(post_id), {:join, user})

  end

  def leave(post_id, user) do

    GenServer.cast(via_tuple(post_id), {:leave, user})

  end

  def get_users(post_id) do

    GenServer.call(via_tuple(post_id), :get_users)

  end

  def init(post_id) do

    {:ok, %{post_id: post_id, users: [], comments: []}}

  end

  def handle_call({:join, user}, _from, state) do

    if user in state.users do

      {:reply, {:error, :already_exists}, state}

    else

      new_state = %{state | users: [user | state.users]}
      {:reply, {:ok, new_state.users}, new_state}

    end

  end

  def handle_cast({:leave, user}, state) do

    new_state = %{state | users: List.delete(state.users, user)}

    {:no_reply, new_state}

  end

  def via_tuple(post_id) do

    {:via, Registry, {Chat.PostRegistry, post_id}}

  end

end

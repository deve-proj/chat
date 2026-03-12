defmodule Chat.Room do
  use GenServer

  def start_link(room_name) do

    GenServer.start_link(__MODULE__, [], name: via_tuple(room_name))

  end


  def join(room_name, user) do

    GenServer.call(via_tuple(room_name), {:join, user})

  end


  def leave(room_name, user) do

    GenServer.cast(via_tuple(room_name), {:leave, user})

  end


  def send_message(room_name, user, message) do

    GenServer.cast(via_tuple(room_name), {:send_message, user, message})

  end


  def get_users(room_name) do

    GenServer.call(via_tuple(room_name), :get_users)

  end

  def init(_) do

    {:ok, %{users: [], messages: []}}

  end


  def handle_call({:join, user}, from, state) do

    if user in state.users do

      {:reply, {:error, :already_exists}, state}


    else

      new_state = %{state | users: [user | state.users]}
      {:reply, {:ok, new_state.users}, new_state}

    end

  end

  def handle_call(:get_users, from, state) do

    {:reply, {:ok, state.users}, state}

  end

  def handle_cast({:leave, user}, state) do

    new_state = %{state | users: List.delete(state.users, user)}

    {:noreply, new_state}

  end

  def handle_cast({:send_message, user, message}, state) do

    new_message = %{user: user, message: message, timestamp: DateTime.utc_now()}
    new_state = %{state | messages: [new_message | state.messages]}

    {:noreply, new_state}

  end

  def handle_cast(_unknown, state) do

    {:no_reply, state}

  end

  def handle_call(_unknown, _from, state) do

    {:reply, {:error, :unknown_call}, state}

  end


  def via_tuple(room_name) do

    {:via, Registry, {Chat.RoomRegistry, room_name}}

  end

end

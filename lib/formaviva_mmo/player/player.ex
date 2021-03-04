defmodule FormavivaMmo.Player.Player do
  use GenServer
  import FormaVivaMmo.World.GameMap

  @up 'UP'
  @down 'DOWN'
  @left 'LEFT'
  @right 'RIGHT'
  @attack 'ATTACK'

  def start_link(options) do
    GenServer.start_link(__MODULE__, :ok, options)
  end

  def init(:ok) do
    {:ok, %{position: {0,0}}}
  end

  def get_position(pid) do
    GenServer.call(pid, :get_position)
  end

  def set_position(pid, {y,x}) do
    GenServer.cast(pid, {:set_position, {y,x}})
  end

  def attack(pid) do
    GenServer.cast(pid, :attack)
  end

  def move(pid, movement) do
    {y,x} = get_position(pid)
    case movement do
        @down -> set_position(pid, {y+1, x})
        @up -> set_position(pid, {y-1, x})
        @left -> set_position(pid, {y, x-1})
        @right -> set_position(pid, {y, x+1})
        @attack -> attack(pid)
    end
  end

  def handle_cast({:set_position, {y,x}}, state) do
    if is_walkable({y,x}) do
        {:noreply, Map.put(state, :position, {y,x})}
    else
        {:noreply, state}
    end
  end

  def handle_call(:get_position, _from, state) do
    {:reply, Map.get(state, :position), state}
  end

  def handle_cast(:attack, state) do

  end
end

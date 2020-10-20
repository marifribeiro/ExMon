defmodule ExMon do
  alias ExMon.{Player, Game}
  alias ExMon.Game.{Status, Actions}

  @computer_name "Robotinik"

  def create_player(name, move_avg, move_rdn, move_heal) do
    Player.build(name, move_avg, move_rdn, move_heal)
  end

  def start_game(player) do
    @computer_name
    |> create_player(:punch, :kick, :heal)
    |> Game.start(player)
    Status.print_round_message(Game.info)
  end

  def make_move(move) do
    Game.info()
    |> Map.get(:status)
    |> handle_status(move)

    computer_move(Game.info)
  end

  defp handle_status(:game_over, _move), do: Status.print_round_message(Game.info())

  defp handle_status(_other, move) do
    move
    |> Actions.fetch_move()
    |> do_move()
  end

  defp do_move({:error, move}), do: Status.print_wrong_move_message(move)
  defp do_move({:ok, move}) do
    case move do
      :move_heal -> Actions.heal()
      move -> Actions.attack(move)
    end

    Status.print_round_message(Game.info)
  end

  defp computer_move(%{turn: :computer, status: :continue}) do
    move = {:ok, Enum.random([:move_avg, :move_rdn, :move_heal])}
    do_move(move)
  end

  defp computer_move(_), do: :ok
end

defmodule ExMon.Game.Status do

  def print_round_message(%{status: :started} = info) do
    IO.puts("\n====== The game has started! ======\n")
    IO.inspect(info)
    IO.puts("----------------------------------")
  end

  def print_round_message(%{status: :continue, turn: player} = info) do
    IO.puts("\n====== #{player}'s turn ======\n")
    IO.inspect(info)
    IO.puts("----------------------------------")
  end

  def print_round_message(%{status: :game_over} = info) do
    IO.puts("\n====== Game over! ======\n")
    IO.inspect(info)
    IO.puts("----------------------------------")
  end

  def print_wrong_move_message(move) do
    IO.puts("\n====== You don't know the move #{move}! ======\n")
  end

  def print_move_message(:computer, :attack, damage) do
    IO.puts("\n====== Player attacked the computer dealing #{damage} points of damage ======\n")
  end

  def print_move_message(:player, :attack, damage) do
    IO.puts("\n====== Computer attacked the player dealing #{damage} points of damage ======\n")
  end

  def print_move_message(player, :heal, life_points) do
    IO.puts("\n====== #{player} healed and now has #{life_points} life points ======\n")
  end
end

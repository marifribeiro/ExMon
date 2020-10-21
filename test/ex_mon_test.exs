defmodule ExMonTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  alias ExMon.Player
  alias ExMon.Helper

  describe "create_player/4" do
    test "returns a player" do
      expected_response = %Player{
        life: 100,
        moves: %{move_avg: :soco, move_heal: :cura, move_rdn: :chute},
        name: "mary"
      }
      assert ExMon.create_player("mary", :chute, :soco, :cura) == expected_response
    end
  end

  describe "start_game/1" do
    test "starts the game and prints a message" do
      player = Player.build("Mari", :soco, :chute, :cura)

      messages = capture_io(fn ->
        assert ExMon.start_game(player) == :ok
      end)

      assert messages =~ "The game has started"
      assert messages =~ "status: :started"
      assert messages =~ "turn: :player"
    end
  end

  describe "make_move/1" do
    test "do a valid move and waits for computer's move" do
      Helper.start_game

      messages = capture_io(fn ->
        ExMon.make_move(:chute)
      end)

      assert messages =~ "Player attacked the computer"
      assert messages =~ "computer's turn"
      assert messages =~ "player's turn"
      assert messages =~ "status: :continue"
    end

    test "receives an invalid move and alert the user" do
      Helper.start_game

      messages = capture_io(fn ->
        ExMon.make_move(:banana)
      end)

      assert messages =~ "You don't know the move"
    end
  end
end

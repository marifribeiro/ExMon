defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.{Game, Player}
  alias ExMon.Helper

  describe "start/2" do
    test "starts the game state" do
      player = Player.build("Mari", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "returns the current game state" do
      Helper.start_game

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rdn: :chute},
          name: "Robotinik"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rdn: :chute},
          name: "Mari"
        },
        status: :started,
        turn: :player
      }

      assert expected_response == Game.info
    end
  end

  describe "update/1" do
    test "returns the game state updated" do
      Helper.start_game

      first_state = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rdn: :chute},
          name: "Robotinik"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rdn: :chute},
          name: "Mari"
        },
        status: :started,
        turn: :player
      }

      assert first_state == Game.info

      new_state = %{
        computer: %Player{
          life: 85,
          moves: %{move_avg: :soco, move_heal: :cura, move_rdn: :chute},
          name: "Robotinik"
        },
        player: %Player{
          life: 50,
          moves: %{move_avg: :soco, move_heal: :cura, move_rdn: :chute},
          name: "Mari"
        },
        status: :started,
        turn: :player
      }

      Game.update(new_state)

      expected_response = %{new_state | turn: :computer, status: :continue}

      assert expected_response == Game.info
    end
  end

  describe "player/0" do
    test "returns the player info" do
      Helper.start_game

      expected_response = %ExMon.Player{
        life: 100,
        moves: %{move_avg: :soco, move_heal: :cura, move_rdn: :chute},
        name: "Mari"
      }

      assert Game.player == expected_response
    end
  end

  describe "turn/0" do
    test "returns the turn info" do
      Helper.start_game

      expected_response = :player

      assert Game.turn == expected_response
    end
  end

  describe "fetch_player/1" do
    test "fetches the info on the player passed as a parameter" do
      Helper.start_game

      expected_response_player = %ExMon.Player{
        life: 100,
        moves: %{move_avg: :soco, move_heal: :cura, move_rdn: :chute},
        name: "Mari"
      }

      expected_response_computer = %ExMon.Player{
        life: 100,
        moves: %{move_avg: :soco, move_heal: :cura, move_rdn: :chute},
        name: "Robotinik"
      }

      assert Game.fetch_player(:player) == expected_response_player
      assert Game.fetch_player(:computer) == expected_response_computer
    end
  end
end

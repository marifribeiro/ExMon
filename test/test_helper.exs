ExUnit.start()

defmodule ExMon.Helper do

  alias ExMon.{Game, Player}

  def start_game() do
    player = Player.build("Mari", :chute, :soco, :cura)
    computer = Player.build("Robotinik", :chute, :soco, :cura)

    Game.start(computer, player)
  end
end

# --------------------------------------
# ルール系モデル
# --------------------------------------
PlayerState = require('./player').PlayerState


class @MaruBatsuRule
  constructor: (rightsForWin, wrongsForLose) ->
    @rightsForWin = rightsForWin
    @wrongsForLose = wrongsForLose

  judgeWin: (player) ->
    player.numOfRights == @rightsForWin

  judge: (player)->
    if @judgeWin(player)
      player.state = PlayerState.Win
      return PlayerState.Win
    return PlayerState.Neutral

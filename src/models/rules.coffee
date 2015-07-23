# --------------------------------------
# ルール系モデル
# --------------------------------------
PlayerState = require('./player').PlayerState


###
n○m✕形式ルール
###
class @MaruBatsuRule
  constructor: (rightsForWin, wrongsForLose) ->
    @rightsForWin = rightsForWin
    @wrongsForLose = wrongsForLose

  judgeWin: (player) ->
    player.numOfRights == @rightsForWin

  judgeLose: (player) ->
    player.numOfWrongs == @wrongsForLose

  judge: (player)->
    if @judgeWin(player)
      player.state = PlayerState.Win
      return PlayerState.Win
    return PlayerState.Neutral

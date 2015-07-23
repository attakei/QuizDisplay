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
    if player.state == PlayerState.Win or player.state == PlayerState.Lose
      return PlayerState.None
    if @judgeWin(player)
      player.state = PlayerState.Win
      return PlayerState.Win
    if @judgeLose(player)
      player.state = PlayerState.Lose
      return PlayerState.Lose
    return PlayerState.Neutral

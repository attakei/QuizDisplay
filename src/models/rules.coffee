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
    player.numOfRights >= @rightsForWin

  judgeLose: (player) ->
    player.numOfWrongs >= @wrongsForLose

  judge: (player)->
    if player.state == PlayerState.Win or player.state == PlayerState.Lose
      return PlayerState.None
    if @judgeWin(player)
      nextState = PlayerState.Win
    else if @judgeLose(player)
      nextState = PlayerState.Lose
    else
      nextState = PlayerState.Neutral
    player.state = nextState
    return nextState

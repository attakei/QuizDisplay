# --------------------------------------
# ルール系モデル
# --------------------------------------
PlayerState = require('./players').PlayerState


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

  displayPositive: (player) ->
    if player.state == PlayerState.Win or player.numOfRights >= @rightsForWin
      return '勝抜'
    '◯ ' + player.numOfRights

  displayNegative: (player) ->
    if player.state == PlayerState.Lose or player.numOfWrongs >= @wrongsForLose
      return '失格'
    '✕ ' + player.numOfWrongs


class @PointsRule
  constructor: (scoreToWin=10, scoreForRight=1, scoreForWrong=-1) ->
    @scoreToWin = scoreToWin
    @scoreForRight = scoreForRight
    @scoreForWrong = scoreForWrong


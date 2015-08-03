# --------------------------------------
# ルール系モデル
# --------------------------------------
PlayerState = require('./players').PlayerState


class RuleBase
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


###
n○m✕形式ルール
###
class @MaruBatsuRule extends RuleBase
  constructor: (rightsForWin, wrongsForLose) ->
    @rightsForWin = rightsForWin
    @wrongsForLose = wrongsForLose

  title: ->
    @rightsForWin + '◯' + @wrongsForLose + '✕'

  judgeWin: (player) ->
    player.rights >= @rightsForWin

  judgeLose: (player) ->
    player.wrongs >= @wrongsForLose

  displayPositive: (player) ->
    if player.state == PlayerState.Win or player.rights >= @rightsForWin
      return '勝抜'
    '◯ ' + player.rights

  displayNegative: (player) ->
    if player.state == PlayerState.Lose or player.wrongs >= @wrongsForLose
      return '失格'
    '✕ ' + player.wrongs


class @PointsRule extends RuleBase
  constructor: (scoreToWin=10, scoreToLose=null, scoreForRight=1, scoreForWrong=-1) ->
    @scoreToWin = scoreToWin
    @scoreToLose = scoreToLose
    @scoreForRight = scoreForRight
    @scoreForWrong = scoreForWrong

  judgeWin: (player) ->
    @calcScore(player) >= @scoreToWin

  judgeLose: (player) ->
    @scoreToLose != null and @calcScore(player) <= @scoreToLose

  calcScore: (player) ->
    return player.rights * @scoreForRight + player.wrongs * @scoreForWrong

  displayPositive: (player) ->
    score = @calcScore(player)
    if score >= @scoreToWin
      return '勝抜'
    else if score >= 0
      return score + ' pts'
    return ''

  displayNegative: (player) ->
    score = @calcScore(player)
    if @scoreToLose != null and score <= @scoreToLose
      return '失格'
    if score < 0
      return score + ' pts'
    return ''

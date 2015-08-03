# --------------------------------------
# ルール系モデル
# --------------------------------------
PlayerState = require('./players').PlayerState
Enum        = require('enum')


# 解答者の状態
#
@Decision = Decision =
  new Enum([
    'Right'  # 正解
    'Wrong'  # 不正解
  ])


class RuleBase
  decide: (player, decision) ->
    if decision == Decision.Right
      @_decideRight(player)
    else if decision == Decision.Wrong
      @_decideWrong(player)

  judge: (player)->
    if player.state == PlayerState.Win or player.state == PlayerState.Lose
      return PlayerState.None
    if @_judgeWin(player)
      nextState = PlayerState.Win
    else if @_judgeLose(player)
      nextState = PlayerState.Lose
    else
      nextState = PlayerState.Neutral
    player.state = nextState
    return nextState

@RuleBase = RuleBase


###
n○m✕形式ルール
###
class @MaruBatsuRule extends RuleBase
  constructor: (@toWin, @toLose) ->

  title: ->
    @toWin + '◯' + @toLose + '✕'

  _decideRight: (player) ->
    player.rights++

  _decideWrong: (player) ->
    player.wrongs++

  _judgeWin: (player) ->
    player.rights >= @toWin

  _judgeLose: (player) ->
    player.wrongs >= @toLose

  displayPositive: (player) ->
    if player.state == PlayerState.Win or player.rights >= @toWin
      return '勝抜'
    '◯ ' + player.rights

  displayNegative: (player) ->
    if player.state == PlayerState.Lose or player.wrongs >= @toLose
      return '失格'
    '✕ ' + player.wrongs


class @PointsRule extends RuleBase
  constructor: (@scoreToWin=10, @scoreToLose=null, @scoreForRight=1, @scoreForWrong=-1) ->

  _judgeWin: (player) ->
    @calcScore(player) >= @scoreToWin

  _judgeLose: (player) ->
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

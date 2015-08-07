# --------------------------------------
# ルール系モデル
# --------------------------------------
PlayerState = require('./players').PlayerState
Enum        = require('enum')


# 正誤判定用Enum
#
@Judge = Judge =
  new Enum([
    'Right'  # 正解
    'Wrong'  # 不正解
  ])


class RuleBase
  # 正誤判定処理
  #
  # @example ある解答者が正解時
  #   rule = new RuleBase()
  #   player = {}
  #   rule.judge(player, Judge.Right)
  #
  # @param [Player] 解答者
  # @param [Judge] 正誤判定
  judge: (player, judgeResult) ->
    if judgeResult == Judge.Right
      @_judgeRight(player)
    else if judgeResult == Judge.Wrong
      @_judgeWrong(player)

  # 正解処理
  # オーバライドしない場合は正解数を増やす
  _judgeRight: (player) ->
    player.rights++

  # 誤答処理
  # オーバライドしない場合は誤答数を増やす
  _judgeWrong: (player) ->
    player.wrongs++

  # 解答者の現状から次の状態を決める
  #
  # @param [Player] 解答者
  checkNextState: (player)->
    if player.state == PlayerState.Win or player.state == PlayerState.Lose
      return player.state
    if @_checkStateWin(player)
      nextState = PlayerState.Win
    else if @_checkStateLose(player)
      nextState = PlayerState.Lose
    else
      nextState = PlayerState.Neutral
#    player.state = nextState
    return nextState

@RuleBase = RuleBase


###
n○m✕形式ルール
###
class @MaruBatsuRule extends RuleBase
  constructor: (@toWin, @toLose) ->

  title: ->
    @toWin + '◯' + @toLose + '✕'

  _checkStateWin: (player) ->
    player.rights >= @toWin

  _checkStateLose: (player) ->
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

  title: ->
    @scoreToWin + 'points'

  _checkStateWin: (player) ->
    @calcScore(player) >= @scoreToWin

  _checkStateLose: (player) ->
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

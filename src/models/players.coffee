# 解答者情報モジュール
Enum = require 'enum'


# 解答者の状態
#
@PlayerState = PlayerState =
  new Enum([
    'None'     # （なにもなし）
    'Neutral'  # 通常状態
    'Answer'   # 解答権取得中
    'Sleep'    # 休み中
    'Win'      # 勝ち抜け
    'Lose'     # 失格
    ])


class @Player
  constructor: (@id, @name) ->
    @numOfRights = 0
    @numOfWrongs = 0
    @state = PlayerState.Neutral

  doRight: ->
    @numOfRights++
    @state = PlayerState.Neutral

  doWrong: ->
    @numOfWrongs++
    @state = PlayerState.Neutral

  vname: ->
    vname = ''
    for idx in [0...@name.length]
      if idx != 0
        vname += '\n'
      vname += @name[idx]
    vname


class @ScorePlayer extends @Player
  displayPositive: ->
    if @state == PlayerState.Win
      return '勝抜'
    @calcScore() + ' pts'

  displayNegative: ->
    ''

  calcScore: ->
    @numOfRights - @numOfWrongs

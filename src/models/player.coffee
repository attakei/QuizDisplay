# 解答者情報モジュール
Enum = require 'enum'


# PlayerState = new Enum(['Neutral', 'Answer', 'Sleep', 'Win', 'Lose'])
@PlayerState = PlayerState =
  new Enum(['None', 'Neutral', 'Answer', 'Sleep', 'Win', 'Lose'])


class @Player
  constructor: (id, name) ->
    @id = id
    @name = name
    @isAnswer = false
    @numOfRights = 0
    @numOfWrongs = 0
    @state = PlayerState.Neutral

  displayPositive: ->
    '◯ ' + @numOfRights

  displayNegative: ->
    '✕ ' + @numOfWrongs

  doRight: ->
    @numOfRights++

  doWrong: ->
    @numOfWrongs++

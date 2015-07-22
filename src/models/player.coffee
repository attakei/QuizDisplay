# 解答者情報モジュール

class @Player
  constructor: (id, name) ->
    @id = id
    @name = name
    @isAnswer = false
    @numOfRights = 0
    @numOfWrongs = 0

  displayPositive: ->
    '◯ ' + @numOfRights

  displayNegative: ->
    '✕ ' + @numOfWrongs

  doRight: ->
    @numOfRights++

  doWrong: ->
    @numOfWrongs++
# 解答者情報モジュール

class @Player
  constructor: (id, name) ->
    @id = id
    @name = name
    @isAnswer = false

  displayPositive: ->
    '○ 1'

  displayNegative: ->
    '✕ 1'

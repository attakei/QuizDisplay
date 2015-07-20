# --------------------------------------
#
# 初期設定Context系パッケージ
#
# --------------------------------------
ProgressContext = require('../progress/index').ProgressContext


# 初期化画面用Context
class @InitContext extends Arda.Context
  component:
    require('./component')
  initState: (props) ->
    cnt: 0
    programName: 'None title'
    maxPlayers: props.maxPlayers or 12
  expandComponentProps: (props, state) ->
    cnt: state.cnt
    programName: state.programName
    maxPlayers: state.maxPlayers
  delegate: (subscribe) ->
    super

    subscribe 'submit', (form) ->
      App.router.pushContext(ProgressContext, form)


# InitComponent用mixn
@InitController =
  getInitialState: ->
    {}

  handleSubmit: ->
    formData = {}
    formData.programName = @linkState('programName').value
    formData.players = []
    for i in [0..@props.maxPlayers]
      val_ = @linkState('player[' + i + ']').value
      val_ = '' if typeof val_ == "undefined"
      formData.players.push(val_)

    @dispatch('submit', formData)

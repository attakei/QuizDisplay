class @MaruBatsuRule extends Arda.Context
  component:
    require('../../components/_rules').MartuBatsuForm

  initState: (props) ->
    toWin: props.toWin or 7
    toLose: props.toLose or 3

  expandComponentProps: (props, state) ->
    toWin: state.toWin
    toLose: state.toLose

  delegate: (subscribe) ->
    super

    subscribe 'submit', () ->
      console.log 'submit rule'

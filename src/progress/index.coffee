class @ProgressContext extends Arda.Context
  component:
    require('./component')
  initState: (props) ->
    quizCount: 0
  expandComponentProps: (props, state) ->
    programName: props.programName
    players: props.players
    quizCount: state.quizCount

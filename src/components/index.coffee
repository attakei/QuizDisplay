@find = (name) ->
  classType = React.createClass
    render: ->
      require('jade-react!./' + name + '.jade') @
  return classType

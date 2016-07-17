module.exports =

  activate: (state) ->

    @subscription = atom.workspace.observeTextEditors (item) ->
      if item.getText().length >= 1024 * 256
        atom.confirm
          message: 'Warning'
          detailedMessage: 'The file you are opening could cause Atom to stop responding.'
          buttons:
            Continue: ->
            Abort: -> item.destroy()

  deactivate: ->
    @subscription.dispose()

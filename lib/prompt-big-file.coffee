module.exports =

  config:
    Threshold:
      default: 1
      type: 'integer'
      description: 'Threshold in Megabytes (MB)'

  activate: (state) ->

    @subscription = atom.workspace.observeTextEditors (item) ->
      if item.getText().length // (1024 * 1024) >= atom.config.get('prompt-big-file.Threshold')
        atom.confirm
          message: 'Warning'
          detailedMessage: 'The file you are opening could cause Atom to stop responding.'
          buttons:
            Continue: ->
            Abort: -> item.destroy()

  deactivate: ->
    @subscription.dispose()

module.exports =

  config:
    Threshold:
      default: 1
      type: 'integer'
      description: 'Threshold in Megabytes (MB)'

  activate: (state) ->

    @subscription = atom.workspace.observeTextEditors (item) ->
      filesize = item.getText().length // (1024 * 1024)
      if filesize >= atom.config.get('prompt-big-file.Threshold')
        atom.confirm
          message: "Warning: Larger than #{atom.config.get('prompt-big-file.Threshold')}Mb"
          detailedMessage: "The file you are opening is #{filesize}Mb which is larger than {atom.config.get('prompt-big-file.Threshold')}Mb, this could cause Atom to stop responding."
          buttons:
            Continue: ->
            Abort: -> item.destroy()

  deactivate: ->
    @subscription.dispose()

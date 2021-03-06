# Publish Event Transport
# -----------------------
# Right now you can either use the internal transport or inbuilt Redis module
# The idea behind making this modular is to allow others to experiment with other message queues / servers

exports.init = () ->
  
  transport = null
  config = {}

  use: (nameOrModule, c = {}) ->
    config = c
    transport = if typeof(nameOrModule) == 'object'
      nameOrModule
    else
      try
        require("./transports/#{nameOrModule}")
      catch e
        throw new Error("Unable to find Publish Event Transport '#{nameOrModule}' internally. Please pass a module")

  load: ->
    @use 'internal' unless transport?
    transport.init(config)
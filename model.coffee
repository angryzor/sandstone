{extender} = require 'properties-pls'
Events = require './events'

class Model
	##
	# Defines a single notifying property with potential custom private property name
	@_addNotifyingProp: (prop, privateProp) ->
		# Calculate as much as possible beforehand.
		# I consider speed to be more important than space in something as fundamental as
		# setting properties.
		privateProp ?= "_#{prop}"
		eventName = "change:#{prop}"

		# Define a notifying property on our prototype.
		Object.defineProperty @::, prop,
			get: ->
				@[privateProp]
			set: (v) ->
				@[privateProp] = v
				@trigger eventName
				@trigger "change"

	@notifyCustom: (obj) ->
		@_addNotifyingProp prop, privateProp for prop, privateProp of obj

	@notify: (props...) ->
		@_addNotifyingProp prop for prop in props

Model = Events.extend Model

Model.extend = extender

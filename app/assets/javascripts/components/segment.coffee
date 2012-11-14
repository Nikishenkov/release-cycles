Crafty.c("Segment",

  innerRadius: Config.cycle.innerRadius.base
  outerRadius: Config.cycle.outerRadius.base
  _inner: null
  _outer: null

  Segment: () ->
    @_inner = Crafty.e("Obstacle").radius(@innerRadius, 'innerRadius').pivot(@pivot).angle(@angle).Obstacle()
    @_outer = Crafty.e("Obstacle").radius(@outerRadius, 'outerRadius').pivot(@pivot).angle(@angle).Obstacle()
    @_distance = @outerRadius - @innerRadius
    @

  pivot: (pivot)->
    @attr('pivot', pivot)
    @

  angle: (angle)->
    @attr('angle', angle)
    @

  preceeding: (segment) ->
    return @ unless segment
    @prev = segment
    segment.next = @
    @

  color: (color) ->
    @_inner.color(color)
    @_outer.color(color)

  upgrade: ->
    @_inner.upgrade()
    @_outer.upgrade()

  reset: ->
    @_inner.reset()
    @_outer.reset()

  perform: (action, value = null, cameFrom = null) ->
    value = Config.actionValues[action] unless value
    return if value < Config.obstacles.effect.threshold
    @[action](value)
    @prev.perform(action, value / Config.obstacles.effect.divisor, 'next') unless cameFrom == 'prev'
    @next.perform(action, value / Config.obstacles.effect.divisor, 'prev') unless cameFrom == 'next'

  Pull: (value) ->
    @_inner.shiftRadius(-value)
    @_outer.shiftRadius(-value)

  Push: (value) ->
    @_inner.shiftRadius(+value)
    @_outer.shiftRadius(+value)

  Fork: (value) ->
    newDist = @_distance + value * 2
    if newDist >= Config.cycle.distance.maximum
      value = (Config.cycle.distance.maximum - @_distance) / 2
    @_inner.shiftRadius(-value)
    @_outer.shiftRadius(+value)

  Merge: (value) ->
    newDist = @_distance - value * 2
    if newDist <= Config.cycle.distance.minimum
      value = (@_distance - Config.cycle.distance.minimum) / 2
    @_inner.shiftRadius(+value)
    @_outer.shiftRadius(-value)
)

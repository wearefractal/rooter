# Hash events
hash =
  listeners: []
  listen: (fn) -> rooter.hash.listeners.push fn
  trigger: (hash=rooter.hash.value()) ->
    hash = "/" if hash is ""
    fn hash for fn in rooter.hash.listeners
    return
  value: (h) ->
    if h
      window.location.hash = h
    return window.location.hash.replace '#', ''

hashTimer =
  listeners: []
  listen: (fn) -> rooter.hash.listeners.push fn
  trigger: (hash=rooter.hash.value()) ->
    hash = "/" if hash is ""
    fn hash for fn in rooter.hash.listeners
    return
  value: (h) ->
    if h
      rooter.hash.lastHash = h
      window.location.hash = h
    return window.location.hash.replace '#', ''

  lastHash: null
  check: ->
    currHash = rooter.hash.value()
    if currHash isnt rooter.hash.lastHash
      rooter.hash.lastHash = currHash
      rooter.hash.trigger currHash
    setTimeout rooter.hash.check, 100
    return

rooter =
  # Routing
  init: ->
    rooter.hash.listen rooter.test
    return rooter.hash.check() if rooter.hash.check
    rooter.hash.trigger()

  routes: {}
  route: (expr, fn) ->
    pattern = "^#{expr}$"
    pattern = pattern
      .replace(/([?=,\/])/g, '\\$1') # escape
      .replace(/:([\w\d]+)/g, '([^/]*)') # name
      .replace(/\*([\w\d]+)/g, '(.*?)') # splat

    rooter.routes[expr] =
      pattern: new RegExp pattern
      fn: fn
    return

  test: (hash) ->
    (d.fn.apply null, m[1..] if m = d.pattern.exec hash) for r, d of rooter.routes
    return

if typeof window.onhashchange isnt 'undefined'
  console.log 'event'
  rooter.hash = hash
  window.onhashchange = -> rooter.hash.trigger rooter.hash.value()
else
  console.log 'timer'
  rooter.hash = hashTimer
  setTimeout rooter.hash.check, 100
window.rooter = rooter

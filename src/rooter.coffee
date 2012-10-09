# Hash events
hash =
  lastHash: null
  listeners: []
  listen: (fn) -> rooter.hash.listeners.push fn
  trigger: (hash=rooter.hash.value()) ->
    rooter.hash.lastHash = hash
    fn hash for fn in rooter.hash.listeners
    return
  value: (h) ->
    if h
      window.location.hash = h
    hash = window.location.hash.replace '#', ''
    hash = "/" if hash is ""
    return hash

hashTimer = {}
hashTimer extends hash
hashTimer.value = (h) ->
    if h
      rooter.hash.lastHash = h
      window.location.hash = h
    return window.location.hash.replace '#', ''
hashTimer.check = ->
    currHash = rooter.hash.value()
    rooter.hash.trigger currHash if currHash isnt rooter.hash.lastHash
    setTimeout rooter.hash.check, 100
    return

rooter =
  lastMatch: null

  routes: []
  route: (expr, fn) ->
    pattern = "^#{expr}$"
    pattern = pattern
      .replace(/([?=,\/])/g, '\\$1') # escape
      .replace(/:([\w\d]+)/g, '([^/]*)') # name
      #.replace(/\*([\w\d]+)/g, '(.*?)') # splat

    o =
      route: expr
      names: expr.match /:([\w\d]+)/g
      pattern: new RegExp pattern
      fn: fn
    rooter.routes.push o

    currHash = rooter.hash.value()
    rooter.triggerMatch currHash, o if rooter.isMatch currHash, o
    return rooter

  isMatch: (hash, r) -> r.pattern.exec(hash)?
  triggerMatch: (hash, r) ->
    rooter.lastMatch = hash
    o = {}
    if r.names
      args = r.pattern.exec(hash)[1..]
      o[name.substring(1)] = args[idx] for name, idx in r.names
    r.fn o
    return

  matches: (hash) -> (r for r in rooter.routes when rooter.isMatch hash, r)
  test: (hash) ->
    matches = rooter.matches hash
    return unless matches.length > 0
    rooter.triggerMatch hash, match for match in matches
    return

if typeof window.onhashchange isnt 'undefined'
  rooter.hash = hash
  window.onhashchange = -> rooter.hash.trigger rooter.hash.value()
else
  rooter.hash = hashTimer
  setTimeout rooter.hash.check, 100

# start listening
rooter.hash.listen rooter.test
rooter.hash.check() if rooter.hash.check

window.rooter = rooter

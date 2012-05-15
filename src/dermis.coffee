define "dermis", ["jade"], (jade) ->
  redirect = (hash) -> window.location.hash = hash

  route = (url, service, view) ->
    base = /\/(.*?)\//.exec(url)[1]
    service ?= "routes/#{base}"
    view ?= "templates/#{base}"
    route = {}
    route[url] = (a)-> require [service, view],(s, t)-> s a,t
    $.routes route

  route: route
  redirect: redirect
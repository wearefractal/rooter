should = require 'should'
require 'mocha'

rooter = require '../src/rooter'

describe 'rooter', ->
  beforeEach -> rooter.routes = {}

  describe 'adding', ->
    it 'should add a new route', (done) ->
      rooter.route '/test/:id', ->
      done()

  describe 'matching', ->
    it 'should match zero fields', (done) ->
      rooter.route '/', done
      rooter.test '/'

    it 'should match one field', (done) ->
      rooter.route '/test/:id', (id) ->
        should.exist id
        id.should.equal '10'
        done()
      rooter.test '/test/10'

    it 'should match one field', (done) ->
      rooter.route '/test/:id/:id2', (id, id2) ->
        should.exist id
        id.should.equal '10'
        should.exist id2
        id2.should.equal '20'
        done()
      rooter.test '/test/10/20'
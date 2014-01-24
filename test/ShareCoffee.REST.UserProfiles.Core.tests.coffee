chai = require 'chai'
sinon = require 'sinon'
chai.should()

root = global ? window

describe 'ShareCoffee.REST.UserProfiles.Core', ->

  it 'should throw an loadError when ShareCoffee is not loaded', ->
    (-> require('../src/ShareCoffee.REST.UserProfiles')).should.throw ''



describe 'ShareCoffee.REST.UserProfiles.Core', ->

  before () ->
    #Fake that ShareCoffee has been loaded
    root.ShareCoffee =
      REST: {}
      RESTFactory: (method) ->
        {method: method}

    require '../src/ShareCoffee.REST.UserProfiles'

  it 'should register a UserProfiles subnamespace on ShareCoffee.REST', ->
    root.ShareCoffee.REST.should.have.property 'UserProfiles'
    root.ShareCoffee.REST.UserProfiles.should.be.an 'object'

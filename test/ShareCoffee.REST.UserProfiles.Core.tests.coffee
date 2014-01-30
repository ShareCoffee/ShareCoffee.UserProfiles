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
      REST: {
        RequestProperties: ()->
      }
      RESTFactory: (method) ->
        {method: method}

    require '../src/ShareCoffee.REST.UserProfiles'

  it 'should register a UserProfiles subnamespace on ShareCoffee.REST', ->
    root.ShareCoffee.REST.should.have.property 'UserProfiles'
    root.ShareCoffee.REST.UserProfiles.should.be.an 'object'

describe 'ProfilePictureProperties', ->

  it 'should expose ProfilePictureProperties as a constructor function on ShareCoffee', ->
    ShareCoffee.should.have.property 'ProfilePictureProperties'
    ShareCoffee.ProfilePictureProperties.should.be.an 'function'

  it 'should accept an image as parameter for ProfilePictureProperties', ->
    sut = new ShareCoffee.ProfilePictureProperties "foo"
    sut.should.have.property "profilePicture"
    sut.profilePicture.should.equal "foo"

  it 'should accept onSuccess as parameter for ProfilePictureProperties', ->
    onSuccess = () ->

    sut = new ShareCoffee.ProfilePictureProperties "foo", onSuccess
    sut.should.have.property "onSuccess"
    sut.onSuccess.should.be.an "function"

  it 'should accept onError as parameter for ProfilePictureProperties', ->
    onError = () ->

    sut = new ShareCoffee.ProfilePictureProperties "foo", null, onError
    sut.should.have.property "onError"
    sut.onError.should.be.an "function"

  it "should expose a getRequestProperties method", ->
    sut = new ShareCoffee.ProfilePictureProperties()
    sut.should.have.property "getRequestProperties"
    sut.getRequestProperties.should.be.an 'function'

  it "should call RequestProperties constructor when getRequestProperties is called", ->
    spy = sinon.spy ShareCoffee.REST, "RequestProperties"
    expectedArgs = [ShareCoffee.UserProfileUrls.updateMyProfileProperty, 'foo', null, null,null,null]

    sut = new ShareCoffee.ProfilePictureProperties "foo"
    actual = sut.getRequestProperties()
    spy.calledOnce.should.be.true
    spy.calledWithExactly expectedArgs

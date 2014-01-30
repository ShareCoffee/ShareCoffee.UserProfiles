chai = require 'chai'
sinon = require 'sinon'
assert = chai.assert
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

describe 'UserProfileProperties', ->

  it 'should exist as a constructor function on ShareCoffee', ->
    ShareCoffee.should.have.property 'UserProfileProperties'
    ShareCoffee.UserProfileProperties.should.be.an 'function'

  it 'should accept url as 1st parameter', ->
    sut = new ShareCoffee.UserProfileProperties 'foo'
    sut.should.have.property 'url'
    sut.url.should.equal 'foo'

  it 'should pass null as url if parameter not present', ->
    sut = new ShareCoffee.UserProfileProperties()
    sut.should.have.property 'url'
    assert.isNull sut.url

  it 'should accept accountName as 2nd parameter', ->
    sut = new ShareCoffee.UserProfileProperties  "url", "Thorsten"
    sut.should.have.property 'accountName'
    sut.accountName.should.equal 'Thorsten'

  it 'should set accountName to null if not present', ->
    sut = new ShareCoffee.UserProfileProperties()
    sut.should.have.property 'accountName'
    assert.isNull sut.accountName

  it 'should accept onSuccess as 3rd parameter for ctor', ->
    onSuccess = ()->
    sut = new ShareCoffee.UserProfileProperties 'url', 'foo', onSuccess
    sut.should.have.property 'onSuccess'
    sut.onSuccess.should.be.an 'function'

  it 'should pass null for onSuccess if not present', ->
    sut = new ShareCoffee.UserProfileProperties()
    sut.should.have.property 'onSuccess'
    assert.isNull sut.onSuccess

  it 'should accept onError as 4th parameter for ctor', ->
    onError = () ->
    sut = new ShareCoffee.UserProfileProperties 'url', 'foo', null, onError
    sut.should.have.property 'onError'
    sut.onError.should.be.an 'function'

   it 'should pass null for onError if not present', ->
     sut = new ShareCoffee.UserProfileProperties()
     sut.should.have.property 'onError'
     assert.isNull sut.onError

   it 'should accept propertyNames as splat parameters for ctor', ->
     sut = new ShareCoffee.UserProfileProperties 'url', "thorsten", null, null, "Email", "AccountName"
     sut.should.have.property 'propertyNames'
     sut.propertyNames.should.be.an 'array'
     sut.propertyNames[0].should.equal 'Email'
     sut.propertyNames[1].should.equal 'AccountName'

   it 'should expose a getRequestProperties method on UserProfileProperties', ->
     sut = new ShareCoffee.UserProfileProperties()
     sut.should.have.property 'getRequestProperties'
     sut.getRequestProperties.should.be.an 'function'

   it 'should call ShareCoffee.REST.RequestProperties when getRequestProperties is invoked', ->
      sut = new ShareCoffee.UserProfileProperties()
      spy = sinon.spy ShareCoffee.REST, "RequestProperties"
      expectedArgs = ['foo', null, null, null, null, null]
      sut = new ShareCoffee.ProfilePictureProperties "foo"
      actual = sut.getRequestProperties()
      spy.calledOnce.should.be.true
      spy.calledWithExactly expectedArgs

      ShareCoffee.REST.RequestProperties.restore()


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

    ShareCoffee.REST.RequestProperties.restore()

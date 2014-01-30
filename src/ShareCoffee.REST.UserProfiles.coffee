root = global ? window

if not root.ShareCoffee? or not root.ShareCoffee.REST?
  throw new Error("LoadError")

root.ShareCoffee.UserProfileUrlRoot = "SP.UserProfiles.PeopleManager"

root.ShareCoffee.UserProfileUrls =
  updateMyProfilePictureUrl :
    "#{ShareCoffee.UserProfileUrlRoot}/SetMyProfilePicture"
  getMyPropertiesUrl:
    "#{ShareCoffee.UserProfileUrlRoot}/GetMyProperties"
  getPropertiesForUserUrl:
    "#{ShareCoffee.UserProfileUrlRoot}/GetPropertiesFor(accountName=@v)?@v="
  getUserProfilePropertyForUserUrl:
    "#{ShareCoffee.UserProfileUrlRoot}/GetUserProfilePropertyFor(accountName=@v, propertyName=@p)?@v=&@p="

root.ShareCoffee.ProfilePictureProperties = class

  constructor: (@profilePicture, @onSuccess, @onError) ->
    @profilePicture = null unless @profilePicture?
    @onSuccess = null unless @onSuccess?
    @onError = null unless @onError?
    @url = ShareCoffee.UserProfileUrls.updateMyProfilePictureUrl

  getRequestProperties: () =>
    payload = @profilePicture
    new ShareCoffee.REST.RequestProperties @url, payload, null, null, @onSuccess, @onError

root.ShareCoffee.UserProfileProperties = class

  constructor: (@url, @accountName = null, @onSuccess = null, @onError = null, @propertyNames...) ->
    @accountName = null unless @accountName?
    @propertyNames = null unless @propertyNames?
    @onSuccess = null unless @onSuccess?
    @onError = null unless @onError?
    @url = null unless @url?

  getUrl: () =>
    url = @url
    if url.indexOf("@v") > -1
      if not @accountName?
        throw new Error 'AccountName not specified'
      url = url.replace '@v=', "@v='#{@accountName}'"
    if url.indexOf("@p") > -1
      props = "PreferredName"
      if not @propertyNames? or @propertyNames.length is 0
        throw new Error 'PropertyName not specified'
      props = @propertyNames[0] if @propertyNames.length > 0
      url = url.replace '@p=', "@p='#{props}'"
    if url.indexOf("SP.UserProfiles.PeopleManager/GetMyProperties") > -1 and @propertyNames.length > 0
      if not @propertyNames? or @propertyNames.length is 0
        throw new Error 'PropertyNames not specified'
      props = ""
      for p in @propertyNames
        props += "#{p},"
      props = props.substr 0, props.length-1
      url = "#{url}?$select=#{props}"
    url

  getRequestProperties: () =>
    new ShareCoffee.REST.RequestProperties @getUrl(), null, null, null, @onSuccess, @onError

root.ShareCoffee.REST.UserProfiles =
  build:
    getMyProfilePicture:
      for: new ShareCoffee.RESTFactory 'GET'
    getMyProperties:
      for: new ShareCoffee.RESTFactory 'GET'
    updateMyProfilePicture:
      for: new ShareCoffee.RESTFactory 'POST'
    getPropertiesForUser:
      for: new ShareCoffee.RESTFactory 'GET'
    getUserProfilePropertyForUser:
      for: new ShareCoffee.RESTFactory 'GET'


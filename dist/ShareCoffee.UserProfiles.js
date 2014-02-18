/*
ShareCoffee.UserProfiles (c) 2014 Thorsten Hans
| dotnet-rocks.com | https://github.com/ThorstenHans/ShareCoffee.UserProfiles/ | under MIT License |
*/


(function() {
  var root;

  root = typeof global !== "undefined" && global !== null ? global : window;

  if ((root.ShareCoffee == null) || (root.ShareCoffee.REST == null)) {
    throw new Error("LoadError");
  }

  root.ShareCoffee.REST.UserProfiles = {};

}).call(this);

/*
//@ sourceMappingURL=ShareCoffee.UserProfiles.js.map
*/
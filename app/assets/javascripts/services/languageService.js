app.factory('Language', ['Restangular', function(Restangular){

  var languages = {};

  function get() {
    return Restangular.all('languages').getList();
  }

  return {
    languages: languages,
    get: get
  };

}]);
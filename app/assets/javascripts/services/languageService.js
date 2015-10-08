app.factory('Language', ['Restangular', function(Restangular){
  var languages = {};

  (function get() {
    Restangular.all('languages').getList().then(function(data) {
      languages = data;
    }, function(error){
      console.log("fail to load languages.")
    });
  })();

  return {
    languages: languages
  }
}])
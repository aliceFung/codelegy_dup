app.factory('api', ['Restangular', function(Restangular){

  var post = function(data){
    return Restangular.all('projects').post(data)
  }

  return {post: post}
}])
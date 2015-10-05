app.factory('api', ['$http', function($http){

  var post = function(data){
    return $http.post('/projects', data)
  }

  return {post: post}
}])
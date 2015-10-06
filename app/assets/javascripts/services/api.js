app.factory('api', ['$http', function($http){

  var post = function(data){
    return $http.post('api/v1/projects', data)
  }

  return {post: post}
}])
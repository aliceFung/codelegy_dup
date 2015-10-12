app.factory('api', ['Restangular', function(Restangular){

  var post = function(data){
    return Restangular.all('projects').post(data)
  }

  var getPage = function(page){
    return Restangular.all('projects').getList({page: page})
  }

  return {post: post,
          getPage: getPage}
}])

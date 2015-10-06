app.controller("projectsCtrl", ['$scope', 'api', 'projects',
  function($scope, api, projects){


  $scope.projects = projects


  $scope.update = function(){
    //replace the argument in api.post with actual data taken from form!
    api.post({title: "api works", difficulty_id: 4}).then(function(response){
      console.log(response)
    })
  }


}])
app.controller("projectsCtrl", ['$scope', 'api', 'projects',
  function($scope, api, projects){


  $scope.projects = projects
  $scope.languages = ['Ruby/Rails','JavaScript','Python','C','Swift','Java','PHP']

  $scope.newProject = {language: $scope.languages[0]}

  $scope.submit = function(newProject){
    //replace the argument in api.post with actual data taken from form!
    api.post(newProject).then(function(response){
      console.log(response)
    })
  }


}])
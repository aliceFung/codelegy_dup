
app.controller("projectsCtrl", ['$scope', '$state', 'api', 'projects', 'languages',
  function($scope, $state, api, projects, languages){

  $scope.currentTime = new Date();

  $scope.projects = projects
  $scope.langFilter = {};
  $scope.languages = [];
  languages.forEach(function(el){
    $scope.languages.push(el.name);
    $scope.langFilter[el.name] = false;
  })

  $scope.newProject = {languages: $scope.langFilter}

  $scope.submit = function(newProject){
    // Convert language filter to array to submit
    $scope.newProject.languages = [];
    for (lang in $scope.langFilter){
      if ($scope.langFilter[lang]) {
        $scope.newProject.languages.push(lang)
      }
    }
    // post the new project object to controller using api service
    api.post(newProject).then(function(response){
      $scope.projects.push(response)
      $state.go('projects')
    }, function(error){
      console.log(error)
    })

    // reset newProject
    $scope.newProject = {languages: $scope.langFilter}
  }

  $scope.addLang = function(language){
    // debugger
    // $(event.target).toggleClass('active')
    $scope.langFilter[language] = !$scope.langFilter[language]
  }

    $scope.updateLangFilter = function(language){
    debugger
    $(event.target).toggleClass('active')
    var idx = $scope.langFilter.indexOf(language)
    if ( idx === -1){
      $scope.langFilter.push(language)
    } else {
      // debugger
      $scope.langFilter.splice(idx, 1)
    }
  }


}])

app.controller("projectsCtrl", ['$scope', '$state', 'api', 'projects', 'languages',
  function($scope, $state, api, projects, languages){

  $scope.moreThan24HrsAgo = function(time) {
    // debugger
    if ((Date.now() - new Date(time))/1000/60/60 > 24) {
      return true
    }
  }


  // $scope.timesFilter = "";
  $scope.difficultyFilter;

  var truthCount = function(){
    var count = 0;
    for (key in $scope.langFilter){
      if ($scope.langFilter[key]){
        count++
      }
    }
    return count
  }

  var checkLang = function(project, idx, arr){
    var array = $.grep(project.languages, function(lang){
      return ($scope.langFilter[lang.name])
    })
    return (array.length == truthCount())
  }

  $scope.projectFilter = function(project, idx, arr){
    return checkLang(project)
  }

  var checkTimes = function(project){
    if (project.availability){
      console.log(project.availability)
      console.log("timesFilter", $scope.timesFilter)
      console.log((project.availability).indexOf($scope.timesFilter) > -1)
    }
    return true
  }

  $scope.projects = projects
  $scope.langFilter = {};
  $scope.languages = [];
  languages.forEach(function(el){
    $scope.languages.push(el.name);
    $scope.langFilter[el.name] = false;
  })

  $scope.grid = true

  $scope.newProject = {languages: $scope.langFilter}

  $scope.toggleGrid = function() {
    $scope.grid = !$scope.grid
  }

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
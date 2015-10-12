app.controller("projectsCtrl", ['$scope', '$state', '$filter', 'api', 'Session', 'projects', 'languages', function($scope, $state, $filter, api, Session, projects, languages){

    $scope.projects = projects
    $scope.langFilter = {};
    $scope. langSuggestions = {};
    $scope.languages = [];
    languages.forEach(function(el){
      $scope.languages.push(el.name);
      $scope.langFilter[el.name] = false;
      $scope.langSuggestions[el.name] = el.suggestions;
    })

$scope.availabilityDays = { monday: false,
                            tuesday: false,
                            wednesday: false,
                            thursday: false,
                            friday: false,
                            saturday: false,
                            sunday: false,
                          }
      $scope.start = {};
      $scope.end = {};
      $scope.timeslots = [];

    $scope.days = ["monday", "tuesday", "wednesday", "thursday",
                   "friday", "saturday", "sunday"]

    $scope.displayPage = 0;

    $scope.nextPage = function () {
      $scope.displayPage += 24
    }

    $scope.prevPage = function () {
      if ($scope.displayPage > 0){
        $scope.displayPage -= 24
      }
    }


    // debugger
    var truthCount = function(){
      var count = 0;
      for (key in $scope.langFilter){
        if ($scope.langFilter[key]){
          count++
        }
      }
      return count
    }


    $scope.moreThan24HrsAgo = function(time) {
      // debugger
      if ((Date.now() - new Date(time))/1000/60/60 > 24) {
        return true
      }
    }

    var checkLang = function(project, idx, arr){
      // debugger
      var array = $.grep(project.language_urls, function(lang){
        return ($scope.langFilter[lang.name])
      })
      return (array.length == truthCount())
    }
  $scope.projectFilter = function(project, idx, arr){
      return checkLang(project)
    }

    $scope.filtered = $filter('filter')($scope.projects, $scope.projectFilter)

    $scope.signedIn = false

    var checkSignIn = (function(){
      Session.signedIn;
    })()

    // $scope.timesFilter = "";
    $scope.difficultyFilter;


    $scope.addDay = function(day){
      $scope.availabilityDays[day] = !$scope.availabilityDays[day]
    }


    var checkTimes = function(project){
      if (project.availability){
        console.log(project.availability)
        console.log("timesFilter", $scope.timesFilter)
        console.log((project.availability).indexOf($scope.timesFilter) > -1)
      }
      return true
    }

    $scope.addTimeslot = function(){
      var min = $scope.start.minute * 60000
      var hour = ($scope.start.hour * 3600000) + (12*3600000 * $scope.start.am)
      var start = new Date(min + hour)
      min = $scope.end.minute * 60000
      hour = ($scope.end.hour * 3600000) + (12*3600000 * $scope.end.am)
      var end = new Date (min + hour)
      for (day in $scope.availabilityDays){
        if ($scope.availabilityDays[day]){
          $scope.timeslots.push({day: day, start: start, end: end})
        }
      }
    }



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

    var nextPage = 2
    var getMoreProjects = function(){
      api.getPage(nextPage++).then(function(response){
        $scope.projects = $scope.projects.concat(response)
        $scope.filtered = $filter('filter')($scope.projects, $scope.projectFilter)
      })
    }

    $scope.$watch('projects.length', function(newVal){
      console.log(newVal)
        getMoreProjects();
    })

    $scope.addLang = function(language){
      $scope.langFilter[language] = !$scope.langFilter[language]
      $scope.filtered = $filter('filter')($scope.projects, $scope.projectFilter)
      $scope.displayPage = 0
    }

      $scope.updateLangFilter = function(language){
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

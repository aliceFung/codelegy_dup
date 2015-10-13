app.controller("projectsCtrl", ['$scope', '$state', '$filter', 'Project', 'Session', 'Timeslot', 'projects', 'languages',
  function($scope, $state, $filter, Project, Session, Timeslot, projects, languages){

    $scope.projects = projects;
    $scope.langFilter = {};
    $scope. langSuggestions = {};
    $scope.languages = [];

    languages.forEach(function(el){
      $scope.languages.push(el.name);
      $scope.langFilter[el.name] = false;
      $scope.langSuggestions[el.name] = el.suggestions;
    });

    $scope.newProject = {};
    $scope.newProjectLanguagesSelected = [];

    // Time slots widget variables and methods ---

    $scope.days = Timeslot.days;
    $scope.hours = Timeslot.hours;
    $scope.minutes = Timeslot.minutes;
    $scope.amPm = Timeslot.amPm;
    $scope.start = Timeslot.startTime;
    $scope.end = Timeslot.endTime;
    $scope.timeslots = Timeslot.all;
    $scope.addTimeslot = Timeslot.add;

    $scope.addDay = function(day){
      Timeslot.addDay(day);
    };

    $scope.clearTimeslot = function(timeslot){
      Timeslot.clear(timeslot);
    };

    // End of Time slots widget -----------------

    $scope.displayPage = 0;

    $scope.nextPage = function () {
      $scope.displayPage += 24;
    };

    $scope.prevPage = function () {
      if ($scope.displayPage > 0){
        $scope.displayPage -= 24;
      }
    };

    var truthCount = function(){
      var count = 0;
      for (var key in $scope.langFilter){
        if ($scope.langFilter[key]){
          count++;
        }
      }
      return count;
    };

    $scope.moreThan24HrsAgo = function(time) {
      if ((Date.now() - new Date(time))/1000/60/60 > 24) {
        return true;
      }
    };

    var checkLang = function(project, idx, arr){
      var array = $.grep(project.language_urls, function(lang){
        return ($scope.langFilter[lang.name]);
      });
      return (array.length == truthCount());
    };

    $scope.projectFilter = function(project, idx, arr){
      return checkLang(project);
    };

    $scope.filtered = $filter('filter')($scope.projects, $scope.projectFilter);

    var checkSignIn = (function(){
      $scope.signedIn = Session.authenticated;
    })();

    var checkTimes = function(project){
      if (project.availability){
        console.log(project.availability);
        console.log("timesFilter", $scope.timesFilter);
        console.log((project.availability).indexOf($scope.timesFilter) > -1);
      }
      return true;
    };

    $scope.grid = true;
    $scope.toggleGrid = function() {
      $scope.grid = !$scope.grid;
    };

    $scope.submit = function(){
      // Convert language filter to array for submisssion
      for (var lang in $scope.langFilter){
        if ($scope.langFilter[lang]) {
          $scope.newProjectLanguagesSelected.push(lang);
        }
      }
      // post the new project object to controller using Project service
      Project.post( $scope.newProject,
                    $scope.timeslots,
                    $scope.newProjectLanguagesSelected).then(function(response){
        $scope.projects.push(response);

        $state.go('projects');
      }, function(error){
        console.log(error);
      });

      // reset newProject
      $scope.newProject = {languages: $scope.langFilter};
    };

    var nextPage = 2;
    var getMoreProjects = function(){
      Project.getPage(nextPage++).then(function(response){
        $scope.projects = $scope.projects.concat(response);
        $scope.filtered = $filter('filter')($scope.projects, $scope.projectFilter);
      });
    };

    $scope.$watch('projects.length', function(newVal){
        getMoreProjects();
    });

    $scope.addLang = function(language){
      $scope.langFilter[language] = !$scope.langFilter[language];
      $scope.filtered = $filter('filter')($scope.projects, $scope.projectFilter);
      $scope.displayPage = 0;
    };

      $scope.updateLangFilter = function(language){
      $(event.target).toggleClass('active');
      var idx = $scope.langFilter.indexOf(language);
      if ( idx === -1){
        $scope.langFilter.push(language);
      } else {
        $scope.langFilter.splice(idx, 1);
      }
    };

}]);

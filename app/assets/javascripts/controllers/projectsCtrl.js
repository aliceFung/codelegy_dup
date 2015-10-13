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

    $scope.days = Timeslot.days;

    $scope.start = {};
    $scope.end = {};
    $scope.timeslots = [];

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

    // $scope.timesFilter = "";
    // $scope.difficultyFilter;

    $scope.addDay = function(day){
      $scope.days[day] = !$scope.days[day];
    };

    var checkTimes = function(project){
      if (project.availability){
        console.log(project.availability);
        console.log("timesFilter", $scope.timesFilter);
        console.log((project.availability).indexOf($scope.timesFilter) > -1);
      }
      return true;
    };

    $scope.addTimeslot = function(){
      var min = $scope.start.minute * 60000;
      var hour = ($scope.start.hour * 3600000) + (12*3600000 * $scope.start.am);
      var start = (min + hour + (new Date).getTimezoneOffset() * 60000);
      min = $scope.end.minute * 60000;
      hour = ($scope.end.hour * 3600000) + (12*3600000 * $scope.end.am);
      var end = (min + hour + (new Date).getTimezoneOffset() * 60000);
      for (var day in $scope.days){
        if ($scope.days[day]){

          // $scope.newProject.day_timeslots_attributes.start/1000, end/1000, $scope.days.indexOf(day);
          $scope.timeslots.push({day: day, start_time: start/1000, end_time: end/1000});
        }
      }
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
      console.log(newVal);
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
        // debugger
        $scope.langFilter.splice(idx, 1);
      }
    };

}]);

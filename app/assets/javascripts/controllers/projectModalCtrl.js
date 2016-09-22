app.controller("projectModalCtrl", ['$scope', 'userProjectService', 'Timeslot',
  function($scope, userProjectService, Timeslot){

// TimeSlot widget
  $scope.days = { Monday: false,
                            Tuesday: false,
                            Wednesday: false,
                            Thursday: false,
                            Friday: false,
                            Saturday: false,
                            Sunday: false,
                          };
  $scope.hours = Timeslot.hours;
  $scope.minutes = Timeslot.minutes;
  $scope.amPm = Timeslot.amPm;
  $scope.start = {};
  $scope.end = {};


  function _createTime(timeEntered){
    var min = timeEntered.minute * 60000;
    var hour = (timeEntered.hour * 3600000) + (12*3600000 * timeEntered.am);
    return (min + hour + (new Date(0)).getTimezoneOffset() * 60000);
  }

  function _resetAvailabilityDays(){
    for(var key in $scope.days){
      $scope.days[key] = false;
    }
    $scope.start.hour = undefined;
    $scope.start.minute = undefined;
    $scope.start.am = undefined;
    $scope.end.hour = undefined;
    $scope.end.minute = undefined;
    $scope.end.am = undefined;
  }

  $scope.addTimeslot = function(){
    var start = _createTime($scope.start);
    var end = _createTime($scope.end);

    if (start < end){
      for (var day in $scope.days){
        if ($scope.days[day]){
          $scope.timeslots.push({day: day, start_time: start/1000, end_time: end/1000});
        }
      }
      _resetAvailabilityDays();
    } else {
      alert("Start time must precede end time");
    }
  }

  $scope.addDay = function(day){
    $scope.days[day] = !$scope.days[day];
  };

  $scope.clearTimeslot = function(timeslot){
    var index = $scope.timeslots.indexOf(timeslot);
    if (confirm('Are you sure?') === true) {
      $scope.timeslots.splice(index, 1);
   }
  };

  // end timeslot widget
  var difficulty_names = ['Beginner','Intermediate', 'Advanced', 'Expert'];
  $scope.project = $scope.$parent.project;
  $scope.languages = $scope.$parent.languages;
  $scope.projectLanguages = $scope.project.language_urls.map(
                              function(val){return val.name});
  $scope.difficulties =[{name: 'Beginner', id: 1},
                        {name: 'Intermediate', id: 2},
                        {name: 'Advanced', id: 3},
                        {name: 'Expert', id: 4}];


  // set/reset edit fields
  var initialize = function(){
    $scope.timeslots = [];
    $scope.project.times.forEach(function(val){
    $scope.timeslots.push({day: val[0],
                      start_time: new Date(val[1]).getTime()/1000,
                      end_time: new Date(val[2]).getTime()/1000});
  });

    $scope.langHash = {};
    $scope.projectLanguages.forEach(function(val){
      $scope.langHash[val] = true;
    });

    $scope.description = $scope.project.description;
    $scope.project.difficulty = {name: $scope.project.difficulty_name, id: difficulty_names.indexOf($scope.project.difficulty_name)+1};

    _resetAvailabilityDays();
  };

  initialize();


  $scope.submit = function(){
    var langs = [];
    for (var lang in $scope.langHash){
      if ($scope.langHash[lang]) {
        langs.push(lang);
      }
    }
    var updatedProject = $scope.project;
    updatedProject.languages = langs;
    updatedProject.description = $scope.description;
    updatedProject.timeslots = $scope.timeslots;
    updatedProject.difficulty_id = $scope.project.difficulty.id;

    userProjectService.update(updatedProject).then(function(response){
      // $scope.$parent.project = response;
      $scope.project.times = response.times;
      $scope.project.language_urls = response.language_urls
      initialize();
      // debugger;
    });
  };

  $scope.cancel = function(){
    initialize();
  };

  $scope.changeMembership = $scope.$parent.changeMembership;



}]);
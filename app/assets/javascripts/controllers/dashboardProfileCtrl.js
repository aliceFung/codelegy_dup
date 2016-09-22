app.controller('dashboardProfileCtrl',
  [ '$scope',
    'profileInfo',
    'ProfileRegistration',
    'Language',
    'Session',
    'Auth',
    'Timeslot',
    'Restangular',
    function($scope, profileInfo, ProfileRegistration, Language, Session, Auth, Timeslot, Restangular){
      $scope.information = profileInfo;
      $scope.languages = Language.languages;
      $scope.expLevel = ProfileRegistration.expLevel;

      // update currentUser info from the resolved profileInfo
      $scope.currentUser = Session.currentUser;
      $scope.currentUser.user = profileInfo.user;

      $scope.profileUpdates = {};
      $scope.profileUpdates.profile_languages = {};
      // $scope.availability = ''; $scope.about = ''; $scope.profile_languages = '';

      $scope.updatedDifficulty = {};
      // language_id : difficulty_id

      $scope.languageSelected  = {};
      // 'name' : langName , 'id' : langId

      $scope.changeDifficulty = function(language_id, difficulty, difficulty_id, pl_id){
        $scope.updatedDifficulty[language_id] = difficulty_id;

        $scope.profileUpdates.profile_languages[language_id] = [];
        $scope.profileUpdates.profile_languages[language_id][1] = pl_id;

        if (difficulty == 'Remove') {
          $scope.profileUpdates.profile_languages[language_id][2] = true;
        } else {
          $scope.profileUpdates.profile_languages[language_id][0] = difficulty_id;
        }
      };

      $scope.update = function(){
        Auth.currentUser().then(function(user){
          ProfileRegistration.update(user.id, $scope.profileUpdates, $scope.information, $scope.languageSelected);
        });
      };

//  Timeslot widget variables and methods
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

  var initialize = function(){
    $scope.timeslots = [];
    $scope.information.times.forEach(function(val){
    $scope.timeslots.push({day: val[0],
                      start_time: new Date(val[1]).getTime()/1000,
                      end_time: new Date(val[2]).getTime()/1000});
  });

    _resetAvailabilityDays();
  };

  initialize();


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

  $scope.submit = function(){
    Restangular.one('timeslots', profileInfo.id).put({
      timeslots: JSON.stringify($scope.timeslots),
      class: "Profile"
    }).then(function(response){
        $scope.information.times = response
        initialize();
        // $('#availModal').css("display", "none");
      })
  };

  $scope.cancel = function(){
    initialize();
    // $('#availModal').css("display", "none");

  };
//  End timeslot variables and methods

}]);
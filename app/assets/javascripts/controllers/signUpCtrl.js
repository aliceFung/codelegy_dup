app.controller('signUpCtrl',
  ['SignUp',
   'Session',
   '$scope',
   'ProfileRegistration',
   '$state', 
   'Timeslot', 
   function(SignUp, Session, $scope, ProfileRegistration, $state, Timeslot){

  $scope.credentials = SignUp.credentials;
  $scope.profileInput = ProfileRegistration.profileInput;

  // On registration, create a new session
  $scope.authenticated = Session.authenticated;
  $scope.currentUser = Session.currentUser;

  // Time slots widget variables and methods
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

  $scope.register = function(){
    console.log(ProfileRegistration.profileInput);
    SignUp.register($scope.credentials, ProfileRegistration.profileInput, $scope.timeslots);
  };

  $scope.$on('devise:new-registration', function(event, user) {
    $scope.currentUser.user = user;
    $scope.authenticated.status = true;
    $state.go('home.tour');
  });

}]);
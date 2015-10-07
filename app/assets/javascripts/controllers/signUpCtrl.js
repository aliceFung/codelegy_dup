app.controller('signUpCtrl',
  ['SignUp',
   'Session',
   '$scope',
   'ProfileRegistration',
   '$state',
   function(SignUp, Session, $scope, ProfileRegistration, $state){

  $scope.credentials = SignUp.credentials;

  // On registration, create a new session
  $scope.authenticated = Session.authenticated;
  $scope.currentUser = Session.currentUser;

  $scope.register = function(){
    SignUp.register($scope.credentials, ProfileRegistration.profileInput);
  };

  $scope.$on('devise:new-registration', function(event, user) {
    $scope.currentUser.user = user;
    $scope.authenticated.status = true;
    $state.go('projects');
  });

}]);
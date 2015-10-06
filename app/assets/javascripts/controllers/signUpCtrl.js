app.controller('signUpCtrl', 
  ['signUpService', 
   'session', 
   '$scope', 
   'profileRegistration', 
   function(signUpService, session, $scope, profileRegistration){

  $scope.credentials = signUpService.credentials;

  // On registration, create a new session
  $scope.authenticated = session.authenticated;
  $scope.currentUser = session.currentUser;

  $scope.register = function(){
    signUpService.register($scope.credentials, profileRegistration.profileInput);
  };

  $scope.$on('devise:new-registration', function(event, user) {
    $scope.currentUser.user = user;
    $scope.authenticated.status = true;
    $state.go('projects');
  });

}]);
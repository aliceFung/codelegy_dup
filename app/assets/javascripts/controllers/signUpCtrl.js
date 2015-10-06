app.controller('signUpCtrl', ['signUpService', 'session', '$scope', function(signUpService, session, $scope){

  $scope.credentials = signUpService.credentials;

  // On registration, create a new session
  $scope.authenticated = session.authenticated;
  $scope.currentUser = session.currentUser;

  $scope.register = function(){
    signUpService.register($scope.credentials);
  };

  $scope.$on('devise:new-registration', function(event, user) {
    $scope.currentUser.user = user;
    $scope.authenticated.status = true;
    $state.go('projects');
  });

}]);
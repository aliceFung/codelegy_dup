app.controller('sessionCtrl', ['$scope', 'session', '$state', function($scope, session, $state){

  $scope.authenticated = session.authenticated;
  $scope.currentUser = session.currentUser;
  $scope.email = '';
  $scope.password = '';
  $scope.credentials = {};

  $scope.signIn = function(){
    session.signIn($scope.credentials);
  };

  $scope.signOut = session.signOut;

  $scope.signInWithGithub = session.signInWithGithub;

  $scope.$on('devise:login', function(event, currentUser) {
    $scope.currentUser.user = currentUser;
    $scope.authenticated.status = true;
    $state.go('home');
  });

  $scope.$on('devise:logout', function(event, oldCurrentUser) {
    $scope.currentUser.user = null;
    $scope.authenticated.status = false;
    $state.go('home');
  });

  $scope.$on('devise:unauthorized', function() {
    $state.go('home.login');
  });
}]);
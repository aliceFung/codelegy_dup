app.controller('sessionController', ['$scope', 'session', '$state', function($scope, session, $state){

  $scope.authenticated = session.authenticated;
  $scope.currentUser = session.currentUser;
  $scope.email = '';
  $scope.password = '';
  $scope.credentials = {};

  $scope.signIn = function(){
    session.signIn($scope.credentials);
  };

  $scope.signOut = session.signOut;

  if (!$scope.authenticated.status){
    $state.go('home.login');
  }

}]);
app.controller('sessionController', ['$scope', 'session', function($scope, session){

  $scope.authenticated = session.authenticated;
  $scope.currentUser = session.currentUser;
  $scope.email = '';
  $scope.password = '';
  $scope.credentials = {};

  $scope.signIn = function(){
    session.signIn($scope.credentials);
  };

  $scope.signOut = session.signOut;

}]);
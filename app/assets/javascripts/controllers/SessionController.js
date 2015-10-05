app.controller('sessionController', ['$scope', 'session', function($scope, session){
  $scope.authenticated = session.authenticated;
})
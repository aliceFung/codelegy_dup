app.controller('emailCtrl', ['$scope', 'emailService',
  function($scope, emailService) {

  console.log('emailCtrl initiated');

  $scope.inbox = emailService.inbox;

  $scope.sendMessage = function(){

  }

}]);

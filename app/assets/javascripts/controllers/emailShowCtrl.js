app.controller('emailShowCtrl', ['$scope', 'emailService', 'Restangular', '$stateParams',
  function($scope, emailService, Restangular, $stateParams) {

  console.log('emailShowCtrl initiated');

  $scope.inbox = emailService.inbox;

  $scope.message = $scope.inbox[$stateParams.id];

}]);

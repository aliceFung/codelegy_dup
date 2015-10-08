app.controller('emailCtrl', ['$scope', 'emailService', 'Restangular',
  function($scope, emailService, Restangular) {

  console.log('emailCtrl initiated');

  $scope.inbox = emailService.inbox;

  $scope.emailDetails = {};
  console.log('initial', $scope.emailDetails);

  // hide/show email details
  $scope.showEmail = function(index){
    if (Object.keys($scope.emailDetails)[0] != index){
      $scope.emailDetails = {};
    }
    $scope.emailDetails[index]  = !$scope.emailDetails[index];
    console.log($scope.emailDetails);
  };

}]);

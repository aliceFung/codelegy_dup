app.controller('emailCtrl', ['$scope', 'emailService', 'Restangular',
  function($scope, emailService, Restangular) {

  // console.log('emailCtrl initiated');

  $scope.inbox = emailService.inbox;

  // $scope.sendMessage = function(project_id){

  // };

}]);

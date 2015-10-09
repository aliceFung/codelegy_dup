app.controller('emailCtrl', ['$scope', 'emailService', 'Restangular',
  function($scope, emailService, Restangular) {

  console.log('emailCtrl initiated');

  $scope.inbox = emailService.inbox;

  $scope.sendMessage = function(project_id){
    var msg = { subject: $scope.msgSubject,
                body: $scope.msgBody};
    // msg.project_id = project_id if project_id
    // Restangular.all('mailbox').post(msg)
  };

}]);

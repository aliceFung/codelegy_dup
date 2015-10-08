app.controller('emailShowCtrl', ['$scope', 'emailService', 'Restangular', '$stateParams',
  function($scope, emailService, Restangular, $stateParams) {

  console.log('emailShowCtrl initiated');

  $scope.inbox = emailService.inbox;

  $scope.message = $scope.inbox[$stateParams.id];

  $scope.deleteMessage = function(){
    Restangular.one('mailbox', $scope.message.id).remove().then(
      function(){
        console.log('delete msg success');
        $scope.inbox.splice($stateParams.id, 1);
      }, function(error){ console.log(error); }
    );
  };

}]);

app.controller('emailShowCtrl', ['$scope', 'emailService', 'Restangular', '$stateParams',
  function($scope, emailService, Restangular, $stateParams) {

  console.log('emailShowCtrl initiated');

  $scope.inbox = emailService.inbox;

  var findEmailIndex = function(){
    for(var i=0; i < $scope.inbox.length; i++){
      if ($scope.inbox[i].id == $stateParams.id){
        return i;
      };
    }
  };

  var emailIndex = findEmailIndex();
  $scope.message = $scope.inbox[emailIndex];

  $scope.deleteMessage = function(){
    Restangular.one('mailbox', $scope.message.id).remove().then(
      function(){
        console.log('delete msg success');
        $scope.inbox.splice(emailIndex, 1);
      }, function(error){ console.log(error); }
    );
  };

}]);

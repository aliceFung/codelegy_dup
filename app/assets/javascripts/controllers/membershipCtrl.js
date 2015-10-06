app.controller('membershipCtrl', ['$scope', '$stateParams', 'emailService', 'Restangular',
  function($scope, $stateParams, emailService, Restangular) {

  // get updated project information, need owner info from API included or get it from the main page
  // $scope.project= Restangular.one('projects', $stateParams.id).get();

  $scope.inbox = emailService.inbox;

  $scope.sendRequest = function(){
    console.log('send request');
    // create pending membership, and send content
    Restangular.all('memberships').post(
          { membership: { project_id: $scope.project.id,
                            user_id: $scope.board.id },
            content: $scope.content})
              .then(function(createdRequest){
                //adding it to inbox
                createdRequest.content = $scope.content;
                $scope.inbox.push(createdRequest);
                  });
  };

}]);

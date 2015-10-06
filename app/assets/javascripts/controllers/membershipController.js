app.controller('membershipController', ['$scope', '$stateParams',
  function($scope, $stateParams) {

  // get updated project information, need owner info from API included
  $scope.project= Restangular.one('projects', $stateParams.id).get();

  $scope.sendRequest = function(){
    console.log('send request');
    Restangular.all('memberships').post(
          { membership: { project_id: $scope.project.id,
                            user_id: $scope.board.id }})
              .then(function(createdRequest){
                createdRequest.content = $scope.content;
                $scope.inbox.push(createdRequest);
                  });
  };

}]);
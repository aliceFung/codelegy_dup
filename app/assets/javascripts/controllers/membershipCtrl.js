app.controller('membershipCtrl', ['$scope', '$stateParams', 'emailService', 'Restangular', '$state',
  function($scope, $stateParams, emailService, Restangular, $state) {

  console.log('membershipCtrl initiated');

  $scope.project = {};

  // get updated project information
  Restangular.one('projects', $stateParams.id).get().then(function(response){
    $scope.project.title = response.title;
    $scope.project.owner_username = response.owner.username;
  });

  //to allow changes to emailService
  $scope.inbox = emailService.inbox;

  $scope.sendRequest = function(){
    console.log('send request');
    // create pending membership, and send content
    Restangular.all('memberships').post(
          { membership: { project_id: $stateParams.id},
            content: $scope.content})
        .then(function(createdRequest){
                //adding it to inbox
                createdRequest.content = $scope.content;
                $scope.inbox.push(createdRequest);
                $state.go('projects');
              },
              function(error){
                    console.log(error);
                    $state.go('projects');
              });
  };

}]);

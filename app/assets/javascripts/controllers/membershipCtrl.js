app.controller('membershipCtrl', ['$scope', '$stateParams', 'emailService', 'Restangular', 'session', '$location',
  function($scope, $stateParams, emailService, Restangular, session, $location) {

  console.log('membershipCtrl initiated');
  // get updated project information, need owner info from API included or get it from the main page as params
  // Restangular.one('projects', $stateParams.id).get().then(function(response){
  //   $scope.project= response
  //   console.log($scope.project);
  // });

  // below is temp until projects index page is complete
  $scope.project= {title: 'new project',
                  owner: 'owner'};

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
                $location.path('/#/projects');
                  }, function(error){
                    console.log(error);
                    $location.path('/#/projects');
                  });
  };

}]);

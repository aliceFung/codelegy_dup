app.controller('membershipCtrl', ['$scope', '$stateParams', 'emailService', 'Restangular', 'session', '$state',
  function($scope, $stateParams, emailService, Restangular, session, $state) {

  console.log('membershipCtrl initiated');

  // get updated project information
  // Restangular.one('projects', $stateParams.id).get().then(function(response){
  //   $scope.project= JSON.parse(response);
  // });


  // below is temp until projects index page is complete
  $scope.project= JSON.parse("{\"id\":152,\"title\":\"myProject\",\"availability\":\"weeknights\",\"description\":\"really awesome!\",\"difficulty_id\":171,\"created_at\":\"2015-10-06T21:45:33.502Z\",\"updated_at\":\"2015-10-06T21:45:33.502Z\",\"difficulty_name\":\"Beginner\",\"owner\":{\"id\":228,\"username\":\"foo11\",\"email\":\"myemail@user11.com\",\"created_at\":\"2015-10-06T21:45:33.499Z\",\"updated_at\":\"2015-10-06T21:45:33.499Z\",\"provider\":\"Github\",\"uid\":\"1234\"}}");


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
                  }, function(error){
                    console.log(error);
                    $state.go('projects');
                  });
  };

}]);

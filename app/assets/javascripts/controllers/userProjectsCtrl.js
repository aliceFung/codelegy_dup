app.controller("userProjectsCtrl", ['$scope', '$state', 'UserProjectService', 'Restangular',
  function($scope, $state, UserProjectService, Restangular){

  console.log('userProjectsCtrl');
  $scope.list = {};
  $scope.list.projectList = UserProjectService.projectList;

  var getRectangularObj = function(membership_id){
    return Restangular.one('memberships', membership_id);
  };

  $scope.changeMembership = function(membership, project, accept){
    var membershipObj = getRectangularObj(membership.id);
    membershipObj.participant_type = accept ? 'member' : 'rejected';
    membershipObj.put().then( function(result){
      console.log(result);
      if (membership.participant_type == 'pending'){
        project.pending_member_count--;
      }
      membership.participant_type = result.participant_type;
    } );
  };

  //can move method to emailService
  $scope.sendMessage = function(project_id, msgSubject, msgBody){
    var msg = { subject: msgSubject,
                body: msgBody,
                project_id: project_id};
    Restangular.all('mailbox').post(msg).then(function(result){
      console.log('success', result);
    }, function(error){
      console.log('error', error);
    });
  };



}]);
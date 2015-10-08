app.controller("userProjectsCtrl", ['$scope', '$state', 'UserProjectService', 'Restangular',
  function($scope, $state, UserProjectService, Restangular){

  console.log('userProjectsCtrl');
  $scope.list = {};
  $scope.list.projectList = UserProjectService.projectList;
  // $scope.projects = $scope.list.projectList.projects;

  //to access membership type of a project (ex: first one in list):
  //$scope.projects[0].owner? // boolean
    // to access # of pending memberships
    // $scope.projects[0].memberships <== list of memberships
    // $$scope.projects[0].pending_member_count

  var getRectangularObj = function(membership_id){
    return Restangular.one('memberships', membership_id);
  };

  $scope.changeMembership = function(membership, project, accept){
    var membershipObj = getRectangularObj(membership.id);
    membershipObj.participant_type = accept ? 'member' : 'rejected';
    membershipObj.put().then( function(result){
      console.log(result);
        debugger;
      if (membership.participant_type == 'pending'){
        project.pending_member_count--;
      };
      membership.participant_type = result.participant_type;
    } );
  };



}]);
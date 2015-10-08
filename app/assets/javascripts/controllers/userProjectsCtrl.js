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

  $scope.changeMembership = function(membership, accept){
    var membershipObj = getRectangularObj(membership.id);
    membershipObj.participation_type = accept ? acc;
    membershipObj.put().then( function(result){
      console.log(result);
      if (membership.participation_type == 'pending'){
        membership.pending_member_count--;
      };
      membership.participation_type = result.participation_type;
    } );
  };



}]);
app.controller("userProjectsCtrl", ['$scope', '$state', 'UserProjectService',
  function($scope, $state, UserProjectService{

  console.log('userProjectsCtrl');
  $scope.list = {};
  $scope.list.projectList = UserProjectService.projectList;
  // $scope.projects = $scope.list.projectList.projects;

  //to access membership type of a project (ex: first one in list):
  //$scope.projects[0].owner? // boolean
    // to access # of pending memberships
    // $scope.projects[0].memberships <== list of memberships
    // $$scope.projects[0].pending_member_count

  $scope.changeMembership = function(membership_id, accept){

  };


}]);
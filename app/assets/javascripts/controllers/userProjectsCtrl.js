app.controller("userProjectsCtrl", ['$scope', '$state', 'UserProjectService', 'ModalService',
  function($scope, $state, UserProjectService){


  $scope.projects = UserProjectService.projects;

  //to access membership type of a project (ex: first one in list):
  //$scope.projects[0].owner? // boolean
    // to access # of pending memberships
    // $scope.projects[0].memberships <== list of memberships
    // $$scope.projects[0].pending_member_count




}]);
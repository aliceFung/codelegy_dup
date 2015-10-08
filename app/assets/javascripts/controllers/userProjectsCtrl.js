app.controller("userProjectsCtrl", ['$scope', '$state', 'UserProjectService', 'ModalService',
  function($scope, $state, UserProjectService){

  console.log('userProjectsCtrl');
  $scope.list = {};
  $scope.list.projectList = UserProjectService.projectList;
  // $scope.projects = $scope.list.projectList.projects;

  //to access membership type of a project (ex: first one in list):
  //$scope.projects[0].owner? // boolean
    // to access # of pending memberships
    // $scope.projects[0].memberships <== list of memberships
    // $$scope.projects[0].pending_member_count

  $scope.manageMembers = function(idxInList){
    ModalService.showModal({
      templateUrl: "/templates/project-modal.html",
      controller: "projectModalCtrl",
      inputs: {
        project: $scope.projects[idxInList],
        projectList: $scope.projects,
        idxInList: idxInList
      }
    }).then(function(modal) {
      //it's a bootstrap element, use 'modal' to show it
      modal.element.modal();
      modal.close.then(function(result) {
        console.log(result);
        // no info sent back from close fn b/c data binding did it
      });
    });
  };


}]);
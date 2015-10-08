app.controller("userProjectsCtrl", ['$scope', '$state', 'UserProjectService',
  function($scope, $state, UserProjectService){


  $scope.projects = UserProjectService.projects;

  $scope.grid = true;

  $scope.toggleGrid = function() {
    $scope.grid = !$scope.grid;
  };



}]);
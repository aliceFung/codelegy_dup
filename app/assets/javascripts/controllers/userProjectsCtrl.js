app.controller("userProjectsCtrl", ['$scope', '$state', 'UserProjectService',
  function($scope, $state, UserProjectService){


  // $scope.currentTime = new Date();

  $scope.projects = UserProjectService.projects;
  $scope.langFilter = {};


  $scope.grid = true;

  $scope.toggleGrid = function() {
    $scope.grid = !$scope.grid;
  };



}]);
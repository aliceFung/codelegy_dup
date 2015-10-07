app.controller('dashboardCtrl',
  [ '$scope',
    'profileInfo',
    function($scope, profileInfo){

      $scope.information = profileInfo;

}]);
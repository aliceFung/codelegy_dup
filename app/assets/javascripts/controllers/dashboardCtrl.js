app.controller('dashboardCtrl',
  [ '$scope',
    'profileInfo', 
    'ProfileRegistration', 
    function($scope, profileInfo, ProfileRegistration){

      $scope.information = profileInfo;
      $scope.languages = ProfileRegistration.languages;
      $scope.expLevel = ProfileRegistration.expLevel;
      
}]);
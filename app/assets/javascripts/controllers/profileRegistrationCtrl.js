app.controller('profileRegistrationCtrl',
  ['$scope',
   'profileRegistration',
    function($scope, profileRegistration){
      $scope.profileInput = profileRegistration.profileInput;
      $scope.languages = profileRegistration.languages;
      $scope.expLevel = profileRegistration.expLevel;

      $scope.setExpLevel = function(language, level) {
        console.log(language, level);

        if (level == 'None') {
          delete $scope.profileInput[language];
        } else {
          $scope.profileInput[language] = level;
        }
      };
}]);
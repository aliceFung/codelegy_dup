app.controller('profileRegistrationCtrl', 
  ['$scope', 
   'profileRegistration', 
    function($scope, profileRegistration){
      $scope.profileInput = profileRegistration.profileInput;
      $scope.languages = profileRegistration.languages;
      $scope.expLevel = profileRegistration.expLevel;

      $scope.setExpLevel = function(language, level) {
        console.log(language, level);
        $scope.profileInput[language] = level;
      };
}]);
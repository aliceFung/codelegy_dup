app.controller('profileRegistrationCtrl',
  ['$scope',
   'profileRegistration',
    function($scope, profileRegistration){
      $scope.profileInput = profileRegistration.profileInput;
      $scope.languages = profileRegistration.languages;
      $scope.expLevel = profileRegistration.expLevel;

      $scope.setExpLevel = function(languageId, levelId) {
        console.log(languageId, levelId);

        if (levelId == 'None') {
          delete $scope.profileInput.profile_languages[languageId];
        } else {
          $scope.profileInput.profile_languages[languageId] = levelId;
        }
      };
}]);
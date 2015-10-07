app.controller('profileRegistrationCtrl',
  ['$scope',
   'ProfileRegistration',
    function($scope, ProfileRegistration){
      $scope.profileInput = ProfileRegistration.profileInput;
      $scope.languages = ProfileRegistration.languages;
      $scope.expLevel = ProfileRegistration.expLevel;

      $scope.setExpLevel = function(languageId, levelId) {
        console.log(languageId, levelId);

        if (levelId == 'None') {
          delete $scope.profileInput.profile_languages[languageId];
        } else {
          $scope.profileInput.profile_languages[languageId] = levelId;
        }
      };
}]);
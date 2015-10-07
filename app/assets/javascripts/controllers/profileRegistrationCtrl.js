app.controller('profileRegistrationCtrl',
  ['$scope',
   'ProfileRegistration',
   '$state',
   'EmailRegEx',
    function($scope, ProfileRegistration, $state, EmailRegEx){
      $scope.profileInput = ProfileRegistration.profileInput;
      $scope.languages = ProfileRegistration.languages;
      $scope.expLevel = ProfileRegistration.expLevel;
      $scope.signupForm = {};

      $scope.emailRegex = EmailRegEx.check;

      $scope.setExpLevel = function(languageId, levelId) {
        console.log(languageId, levelId);

        if (levelId == 'None') {
          delete $scope.profileInput.profile_languages[languageId];
        } else {
          $scope.profileInput.profile_languages[languageId] = levelId;
        }
      };

      $scope.processForm = function(formIsValid){
        if(formIsValid){
          $state.go('home.form.languages');
        }
      };
}]);
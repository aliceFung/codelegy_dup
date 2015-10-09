app.controller('profileRegistrationCtrl',
  ['$scope',
   'ProfileRegistration',
   '$state',
   'EmailRegEx',
   'languageList',
    function($scope, ProfileRegistration, $state, EmailRegEx, languageList){
      $scope.profileInput = ProfileRegistration.profileInput;
      $scope.languages = {};
      $scope.expLevel = ProfileRegistration.expLevel;
      $scope.signupForm = {};

      $scope.emailRegex = EmailRegEx.check;

      languageList.forEach(function(ele){
        $scope.languages[ele.id] = ele.name;
      });

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

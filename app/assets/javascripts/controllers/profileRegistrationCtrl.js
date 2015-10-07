app.controller('profileRegistrationCtrl',
  ['$scope',
   'ProfileRegistration',
   '$state',
    function($scope, ProfileRegistration, $state){
      $scope.profileInput = ProfileRegistration.profileInput;
      $scope.languages = ProfileRegistration.languages;
      $scope.expLevel = ProfileRegistration.expLevel;
      $scope.signupForm = {};

      $scope.emailRegex = /^[-a-z0-9~!$%^&*_=+}{\'?]+(\.[-a-z0-9~!$%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/i;

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
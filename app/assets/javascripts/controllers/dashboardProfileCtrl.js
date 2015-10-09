app.controller('dashboardProfileCtrl',
  [ '$scope',
    'profileInfo',
    'ProfileRegistration',
    'Language',
    'Session',
    'Auth',
    function($scope, profileInfo, ProfileRegistration, Language, Session, Auth){

      $scope.information = profileInfo;
      $scope.languages = Language.languages;
      $scope.expLevel = ProfileRegistration.expLevel;

      $scope.profileUpdates = {};
      // $scope.availability = '';
      // $scope.about = '';
      // $scope.languages = '';

      $scope.updatedDifficulty = {};  // language_id : difficulty_id
      // $scope.profileUpdates.profile_languages = $scope.languages;

      $scope.changeDifficulty = function(language_id, difficulty, difficulty_id){
        $scope.updatedDifficulty[language_id] = difficulty_id;
      };

      $scope.updateLanguage = function(){
        for (var i = 0; i < $scope.languages.length; i++){
          var current_language_id = $scope.languages[i].id.toString();
          console.log('current_language_id', current_language_id);

          var languagesIdsUpdated = Object.keys($scope.updatedDifficulty);
          var index = languagesIdsUpdated.indexOf(current_language_id);

          console.log('keys', Object.keys($scope.updatedDifficulty));
          console.log(index);

          if (index > -1){
            if ($scope.updatedDifficulty[current_language_id] == 'None') {
              delete $scope.profileUpdates.profile_languages[i];
            } else {
              $scope.profileUpdates.profile_languages[i] = $scope.updatedDifficulty[current_language_id];
            }
          }
        }
        $scope.update();
      };

      $scope.update = function(){
        console.log($scope.profileUpdates);
        Auth.currentUser().then(function(user){
          ProfileRegistration.update(user.id, $scope.profileUpdates, $scope.information);
        });
      };

}]);
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
      $scope.profileUpdates.profile_languages = {};
      // $scope.availability = '';
      // $scope.about = '';
      // $scope.languages = '';

      $scope.updatedDifficulty = {};  // language_id : difficulty_id

      $scope.changeDifficulty = function(language_id, difficulty, difficulty_id, pl_id){
        $scope.updatedDifficulty[language_id] = difficulty_id;

        if (difficulty == 'None') {
          delete $scope.profileUpdates.profile_languages[language_id];
        } else {
          $scope.profileUpdates.profile_languages[language_id] = [];
          $scope.profileUpdates.profile_languages[language_id][0] = difficulty_id;
          $scope.profileUpdates.profile_languages[language_id][1] = pl_id;
        }
      };

      $scope.update = function(){
        Auth.currentUser().then(function(user){
          ProfileRegistration.update(user.id, $scope.profileUpdates, $scope.information);
        });
      };

}]);
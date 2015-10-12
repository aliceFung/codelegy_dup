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

      // update currentUser info from the resolved profileInfo
      $scope.currentUser = Session.currentUser;
      $scope.currentUser.user = profileInfo.user;

      $scope.profileUpdates = {};
      $scope.profileUpdates.profile_languages = {};
      // $scope.availability = ''; $scope.about = ''; $scope.profile_languages = '';

      $scope.updatedDifficulty = {};
      // language_id : difficulty_id

      $scope.languageSelected  = {};
      // 'name' : langName , 'id' : langId

      $scope.changeDifficulty = function(language_id, difficulty, difficulty_id, pl_id){
        $scope.updatedDifficulty[language_id] = difficulty_id;

        $scope.profileUpdates.profile_languages[language_id] = [];
        $scope.profileUpdates.profile_languages[language_id][1] = pl_id;

        if (difficulty == 'Remove') {
          $scope.profileUpdates.profile_languages[language_id][2] = true;
        } else {
          $scope.profileUpdates.profile_languages[language_id][0] = difficulty_id;
        }
      };

      $scope.update = function(){
        Auth.currentUser().then(function(user){
          ProfileRegistration.update(user.id, $scope.profileUpdates, $scope.information, $scope.languageSelected);
        });
      };

}]);
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

      $scope.update = function(){
        console.log('dashboardProfileCtrl running');
        Auth.currentUser().then(function(user){
          ProfileRegistration.update(user.id, $scope.profileUpdates, $scope.information);
        });
      };

}]);
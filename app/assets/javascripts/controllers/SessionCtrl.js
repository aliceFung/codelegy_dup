app.controller('sessionCtrl',
  ['$scope', 'Session', '$state', 'EmailRegEx',
  function($scope, Session, $state, EmailRegEx){

  $scope.authenticated = Session.authenticated;
  $scope.currentUser = Session.currentUser;
  $scope.email = '';
  $scope.password = '';
  $scope.credentials = {};
  $scope.emailRegex = EmailRegEx.check;

  $scope.processForm = function(validInput){
    if(validInput){
      $scope.signIn();
    } else {
      alert("Please enter valid information!");
    }
  };

  $scope.signIn = function(){
    Session.signIn($scope.credentials);
  };

  $scope.signOut = Session.signOut;

  $scope.signInWithGithub = Session.signInWithGithub;

  $scope.$on('devise:login', function(event, currentUser) {
    $scope.currentUser.user = currentUser;
    $scope.authenticated.status = true;
    $state.go('home');
  });

  $scope.$on('devise:logout', function(event, oldCurrentUser) {
    $scope.currentUser.user = null;
    $scope.authenticated.status = false;
    $state.go('home');
  });

  $scope.$on('devise:unauthorized', function() {
    $state.go('home.login');
  });
}]);
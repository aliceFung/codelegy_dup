<<<<<<< HEAD
app.controller('sessionCtrl',
  ['$scope', 'Session', '$state', 'EmailRegEx', 'SignUp', 
  function($scope, Session, $state, EmailRegEx, SignUp){
=======
app.controller('sessionCtrl', ['$scope', 'Session', '$state', 'EmailRegEx',
  function($scope, Session, $state, EmailRegEx){
>>>>>>> 45902f5c902f4625cf5cbe10c6363f79cdbb544a

  $scope.authenticated = Session.authenticated;
  $scope.currentUser = Session.currentUser;
  $scope.email = "";
  $scope.password = '';
  $scope.credentials = {};
  $scope.emailRegex = EmailRegEx.check;
  // $scope.authenticated = Session.authenticated; // duplicate
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

  $scope.resetPassword = function(){
    SignUp.resetPassword($scope.resetPasswordForm.email);
    $scope.showResetPasswordForm = false;
  }

  $scope.$on('devise:login', function(event, currentUser) {
    $scope.currentUser.user = currentUser;
    $scope.authenticated.status = true;
    // $state.go('home');
  });

  $scope.$on('devise:logout', function(event, oldCurrentUser) {
    $scope.currentUser.user = null;
    $scope.authenticated.status = false;
    $state.go('home');
  });

  $scope.$on('devise:unauthorized', function() {
    $state.go('home.signin');
  });
}]);

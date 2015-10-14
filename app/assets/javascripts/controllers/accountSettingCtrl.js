app.controller('accountSettingCtrl',
  ['$scope',
   'Session',
   'SignUp',
   'EmailRegEx',
   'profileInfo',
   function($scope, Session, SignUp, EmailRegEx, profileInfo){

  $scope.currentUser = Session.currentUser;
  $scope.currentUser.user = profileInfo.user;
  $scope.emailRegex = EmailRegEx.check;
  $scope.photo_url = profileInfo.photo_url;
  $scope.userInfo = {};

  $scope.cancelAccount = function(){
    var proceed = confirm("Are you sure you want to delete your account?");
    if (proceed) {
      SignUp.cancelAccount();
    }
  };

  $scope.processForm = function(isValidForm){
    if (isValidForm) {
      update();
      $scope.showEditForm = false;
    } else {
      alert('Please fill required valid information!');
    }
  };

  function update(){
    console.log("userForm: ", $scope.userInfo);
    SignUp.update($scope.userInfo);
  }

}]);
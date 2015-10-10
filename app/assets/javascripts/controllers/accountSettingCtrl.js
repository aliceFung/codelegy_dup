app.controller('accountSettingCtrl', 
  ['$scope', 
   'Session', 
   'SignUp', 
   'EmailRegEx', 
   function($scope, Session, SignUp, EmailRegEx){
  
  $scope.currentUser = Session.currentUser;
  $scope.emailRegex = EmailRegEx.check;

  $scope.cancelAccount = function(){
    var proceed = confirm("Are you sure you want to delete your account?");
    if (proceed) {
      SignUp.cancelAccount();
    }
  }

  $scope.processForm = function(isValidForm){
    if (isValidForm) {
      update(); 
      $scope.showEditForm = false
    } else {
      alert('Please fill required valid information!');
    }
  }

  function update(){
    console.log("userForm: ", $scope.userInfo);
    SignUp.update($scope.userInfo);
  }
}])
app.controller('accountSettingCtrl',
  ['$scope',
   'Session',
   'SignUp',
   'EmailRegEx',
   'profileInfo',
   'ProfileRegistration',
   'Upload',
   function($scope, Session, SignUp, EmailRegEx, profileInfo, ProfileRegistration, Upload){

  $scope.currentUser = Session.currentUser;
  $scope.currentUser.user = profileInfo.user;
  $scope.emailRegex = EmailRegEx.check;
  $scope.photo_url = profileInfo.photo_url;

  $scope.userInfo = {};
  $scope.profileUpdate = {};

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

  function createFileObject(oldObj){
    var newObj = {};
    for(var key in oldObj){
      newObj[key] = oldObj[key];
    }
    return newObj;
  }

  function uploadPhoto(){
    var createOrUpdate = $scope.photo_url ? 'PUT' : 'POST';
    var addToURL = $scope.photo_url ? profileInfo.photos[0].id : '';

    Upload.upload({
      url: '/api/v1/photos/'+ addToURL,
      data: {photos: {picture: $scope.profileUpdate.photoFile}},
      method: createOrUpdate,
      contentType: 'application/json'
    }).then(function(response){
      $scope.photo_url = response.data.picture_url;
      }, function(error){
        alert(error.data);
      }
    );
  }

  function update(){
    SignUp.update($scope.userInfo);
    uploadPhoto();
  }

}]);
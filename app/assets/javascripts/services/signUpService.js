app.factory('SignUp',
  ['Auth',
   '$state',
   'Restangular',
   'Session',
   function(Auth, $state, Restangular, Session){

  var credentials = {};

  function register(credentials, profile, timeslots){
    var config = {
        headers: {
            'X-HTTP-Method-Override': 'POST'
        }
    };

    Auth.register(credentials, config).then(function(registeredUser) {
      var profileInfo = {};
      // Send information to backend to create user profile
      profileInfo.user_id = registeredUser.id;
      profileInfo.availability = profile.availability;
      profileInfo.profile_languages_attributes = processProfileInput(profile.profile_languages);
      Restangular.all('profiles').customPUT({profile: profileInfo, timeslots: timeslots}).then(function(profile){
        console.log('updated profile: ', profile);
      }, function(error) {
        console.log('cannot update profile');
      });

    }, function(error) {
      alert('Registration failed: ' + '\n' + printErrors(error.data.errors));
    });
  }

  function printErrors(errors){
    var result = '';
    for(var field in errors) {
      errors[field].forEach(function(error){
        result += (field.toUpperCase() + ': ' + error + '\n');
      })
    }
    return result;
  }

  function processProfileInput(profileInput) {
    var count = 1;
    var result = {};
    for(var key in profileInput) {
      result[count] = {language_id: key, difficulty_id: profileInput[key][0]};
      count++;
    }
    return result;
  }

  function update(userInfo) {
    Restangular.oneUrl('users', 'http://localhost:3000/users.json').customPUT({user: userInfo}).then(function(user){
      if (userInfo.username) {
        Session.currentUser.user.username = userInfo.username;
      }
      if (userInfo.email) {
        Session.currentUser.user.email = userInfo.email;
      }
    }, function(error){
      alert('Update failed: ' + '\n' + printErrors(error.data.errors));
    });
  }

  function cancelAccount() {
    Restangular.oneUrl('users', 'http://localhost:3000/users.json').remove().then(function(){
      Session.currentUser.user = null;
      Session.authenticated.status = false;
      $state.go('home');
    }, function(error){
      alert('Sorry, failed to delete your account, please try again later.');
    });
  }

  function resetPassword(email) {
    Restangular.oneUrl('users', 'http://localhost:3000/users/password.json')
           .customPOST({user: { email: email }})
           .then(function(data){
      alert('Reset Password Email has been sent, please check you mailbox!')
    }, function(error){
      alert('Error: \n' + printErrors(error.data.errors))
    })
  }

  return {
    register: register,
    credentials: credentials,
    update: update,
    cancelAccount: cancelAccount, 
    resetPassword: resetPassword
  };

}]);
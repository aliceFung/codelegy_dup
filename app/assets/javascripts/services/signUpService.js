app.factory('SignUp', ['Auth', '$state', 'Restangular', function(Auth, $state, Restangular){

  var credentials = {};

  function register(credentials, profile){
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
      Restangular.all('profiles').customPUT({profile: profileInfo}).then(function(profile){
        console.log('updated profile: ', profile);
      }, function(error) {
        console.log('cannot update profile');
      });

    }, function(error) {
      console.log(error.data.errors);
      alert('Registration failed: ' + '\n' + printErrors(error.data.errors));
    });
  }

  function printErrors(errors){
    var result = '';
    for(var field in errors) {
      errors[field].forEach(function(error){
        result += (field.toUpperCase() + ': ' + error + '\n');
      });
    }
    return result;
  }

  function processProfileInput(profileInput) {
    var count = 1;
    var result = {};
    for(var key in profileInput) {
      result[count] = {language_id: key, difficulty_id: profileInput[key]};
      count++;
    }
    return result;
  }

  return {
    register: register,
    credentials: credentials
  };

}]);
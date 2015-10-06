app.factory('signUpService', ['Auth', '$state', 'Restangular', function(Auth, $state, Restangular){

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
      profileInfo.profile_languages_attributes = processProfileInput(profile.profile_languages);
      Restangular.all('profiles').customPOST({profile: profileInfo});

    }, function(error) {
      alert('Registration failed');
    });
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
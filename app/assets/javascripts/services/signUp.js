app.factory('signUpService', ['Auth', '$state', 'Restangular', function(Auth, $state, Restangular){

  var credentials = {};

  function register(credentials, profile){
    var config = {
        headers: {
            'X-HTTP-Method-Override': 'POST'
        }
    };

    // credentials.profile = profile;
    // profileInput = { user_id: 1, profile_languages: {} };

    Auth.register(credentials, config).then(function(registeredUser) {

      // CURRENTLY HERE
      console.log(profile); // => {id: 1, ect: '...'}    // {user_id:}
      // Send information to backend to create user profile
      profile.user_id = registeredUser.id;
      profile.profile_languages_attributes = processProfileInput(profile.profile_languages);
      Restangular.all('profiles').post(profile);
    }, function(error) {
      alert('Registration failed');
    });
  }
  
  function processProfileInput(profileInput) {
    var result = [];
    for (key in profileInput) {
      result.push({languange_id: key, difficulty_id: profileInput[key]})
    }
    return result;
  }

  return {
    register: register,
    credentials: credentials
  };

}]);
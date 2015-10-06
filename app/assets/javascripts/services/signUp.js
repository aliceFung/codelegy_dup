app.factory('signUpService', ['Auth', '$state', 'Restangular', function(Auth, $state, Restangular){

  var credentials = {};

  function register(credentials, profile){
    var config = {
        headers: {
            'X-HTTP-Method-Override': 'POST'
        }
    };

    // credentials.profile = profile;

    Auth.register(credentials, config).then(function(registeredUser) {

      // CURRENTLY HERE
      console.log(profile); // => {id: 1, ect: '...'}    // {user_id:}
      // Send information to backend to create user profile
      profile.user_id = registeredUser.id;
      Restangular.all('profiles').post(profile);
    }, function(error) {
      alert('Registration failed');
    });
  }

  return {
    register: register,
    credentials: credentials
  };

}]);
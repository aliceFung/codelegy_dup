app.factory('signUpService', ['Auth', '$state', function(Auth, $state){

  var credentials = {};

  function register(credentials, profile){
    var config = {
        headers: {
            'X-HTTP-Method-Override': 'POST'
        }
    };

    credentials.profile = profile;

    Auth.register(credentials, config).then(function(registeredUser) {
      console.log(registeredUser); // => {id: 1, ect: '...'}
    }, function(error) {
      alert('Registration failed');
    });
  }

  return {
    register: register,
    credentials: credentials
  };

}]);
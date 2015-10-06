app.factory('signUpService', ['Auth', '$state', function(Auth, $state){

  var credentials = {};

  function register(credentials){
    var config = {
        headers: {
            'X-HTTP-Method-Override': 'POST'
        }
    };

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
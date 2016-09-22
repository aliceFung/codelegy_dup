app.factory('Session', ['Auth', '$state', 'Restangular', function(Auth, $state, Restangular){
  var authenticated = { status: Auth.isAuthenticated() };
  var currentUser = { user: Auth.currentUser() };

  function signIn(credentials) {
    var config = {
        headers: {
            'X-HTTP-Method-Override': 'POST'
        }
    };

    Auth.login(credentials, config).then(function(user){
      currentUser.user = user;
      authenticated.status = true;
      $state.go('dashboard');
    }, function(error){
      alert('Sign in failed: ' + error.data.error);
      authenticated.status = false;
    });

  }

  function signOut () {
    var config = {
        headers: {
            'X-HTTP-Method-Override': 'DELETE'
        }
    };

    Auth.logout(config).then(function(oldUser){
      currentUser.user = null;
      authenticated.status = false;
      $state.go('home');
    }, function(error){
      alert('Sign out failed: ' + error.data.error);
    });
  }

  return {
    authenticated: authenticated,
    currentUser: currentUser,
    signIn: signIn,
    signOut: signOut
  };
}]);

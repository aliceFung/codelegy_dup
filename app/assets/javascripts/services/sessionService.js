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
      console.log('Signed In');
      currentUser.user = user;
      authenticated.status = true;
      $state.go('home');
    }, function(error){
      console.log('Sign In Failed:', error);
      authenticated.status = false;
    });

  }

  function signInWithGithub() {
    console.log('sign in with github');
    Restangular.all('users').customGET('auth/github', {}, { 'Access-Control-Allow-Origin': 'http://localhost:3000' });
  }

  function signOut () {
    var config = {
        headers: {
            'X-HTTP-Method-Override': 'DELETE'
        }
    };

    Auth.logout(config).then(function(oldUser){
      console.log('Signed Out' + oldUser);
      currentUser.user = null;
      authenticated.status = false;
      $state.go('home');
    }, function(error){
      console.log('Sign Out Failed:', error);
    });
  }

  return {
    authenticated: authenticated,
    currentUser: currentUser,
    signIn: signIn,
    signInWithGithub: signInWithGithub,
    signOut: signOut
  };
}]);
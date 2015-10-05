app.factory('session', ['Auth', function(Auth){
  var authenticated = { status: Auth.isAuthenticated() };
  var currentUser = { user: Auth.currentUser() };

  function signIn(credentials) {
    var config = {
        headers: {
            'X-HTTP-Method-Override': 'POST'
        }
    }

    Auth.login(credentials, config).then(function(user){
      console.log('Signed In');
      currentUser.user = user;
      authenticated.status = true;
      // $state.go('home.boards');
    }, function(error){
      console.log('Sign In Failed:', error);
      authenticated.status = false;
    })

  }

  function signOut (argument) {
    var config = {
        headers: {
            'X-HTTP-Method-Override': 'DELETE'
        }
    };

    Auth.logout(config).then(function(){
      console.log('Signed Out');
      currentUser.user = null;
      authenticated.status = false;
      // $state.go('home');
    }, function(error){
      console.log('Sign Out Failed:', error);
    })
  }

  return {
    authenticated: authenticated,
    currentUser: currentUser,
    signIn: signIn,
    signOut: signOut
  }
}])
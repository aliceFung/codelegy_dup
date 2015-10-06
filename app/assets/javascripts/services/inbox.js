app.factory('inbox', ['Restangular', function(Restangular){

  var inbox = {};
  //get emails for inbox
  Restangular.all('emails').getList().then(
    function(result){
      inbox.history = result;
    }
  );

  return {
    inbox: inbox
  };

}]);
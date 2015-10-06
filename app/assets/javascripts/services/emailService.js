app.factory('emailService', ['Restangular', function(Restangular){

  var inbox = [];
  //get emails for inbox
  Restangular.all('emails').getList().then(
    function(result){
      inbox.push.apply(inbox, result);
    }
  );

  return {
    inbox: inbox
  };

}]);
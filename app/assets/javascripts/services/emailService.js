app.factory('emailService', ['Restangular', function(Restangular){

  var inbox = [];
  //get emails for inbox
  Restangular.all('mailbox').getList().then(
    function(result){
      inbox.push.apply(inbox, result);
    }
  );

  return {
    inbox: inbox
  };

}]);
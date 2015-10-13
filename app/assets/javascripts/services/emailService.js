app.factory('emailService', ['Restangular', function(Restangular){

  // console.log('emailService started');

  var inbox = [];
  //get emails for inbox
  Restangular.all('mailbox').getList().then(
    function(result){
      inbox.push.apply(inbox, result);
      // console.log('results', result);
    }
  );

  return {
    inbox: inbox
  };

}]);
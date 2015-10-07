app.factory('emailService', ['Restangular', function(Restangular){

  console.log('email service initiated');

  var inbox = [];
  //get emails for inbox
  Restangular.all('mailbox').getList().then(
    function(result){
      inbox.push.apply(inbox, result);
      debugger;
    }
  );

  return {
    inbox: inbox
  };

}]);
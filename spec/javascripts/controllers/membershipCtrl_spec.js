describe('Controller: membershipCtrl', function(){
  // Before each test, instantiate a mocked version of our angular module.
  beforeEach(module('app'));

  // In addition, we make a mocked version of the email service
  // to return some fake data without needing to make any http requests.
  var ctrl, scope, mockEmailService;
  beforeEach(module(function($provide){
    mockEmailService = {
      inbox: [{
        "user_id": 1,
        "project_id": 1,
        "text": "I want to join this awesome project.",
        "to_everyone": false
      }]
    }
    $provide.value("emailService", mockEmailService)
  }))

  // Finally, before each test, we instantiate a fresh membershipCtrl.
  beforeEach(inject(function($controller){
    // By setting a scope object and passing it into $controller,
    // we can ask about the scope of the controller by asking `scope`.
    scope = {}
    ctrl = $controller('membershipCtrl', { $scope: scope });
  }))

  describe('$scope.inbox', function(){
    it('should properly get inbox from emailService', function(){
      expect(scope.inbox.length).toEqual(1);
    })
  })
})

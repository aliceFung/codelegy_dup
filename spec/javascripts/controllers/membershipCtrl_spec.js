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
    // Mock out the session dependancy to avoid redirection from not
    // being logged in.
    $provide.value("session", {})
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

  var mockApi;
  describe('$scope.sendRequest() success', function(){
    beforeEach(inject(function($controller, $httpBackend){
      mockApi = $httpBackend;
      mockApi.expectPOST('/api/v1/memberships.json').respond(200,[
        {
          "user_id": 1,
          "project_id": 1,
          "text": "I want to join this awesome project.",
          "to_everyone": false
        }
        ])
    }))

    it('should add the resulting membership to the inbox upon success', function(){
      scope.project = { id : 1 };
      scope.board = { id : 1 };
      scope.content = "I want to join this awesome project.";
      scope.sendRequest()

      mockApi.flush()
      expect(scope.inbox.length).toEqual(2)
    })
  })

  describe('$scope.sendRequest() failure', function(){
    beforeEach(inject(function($controller, $httpBackend){
      mockApi = $httpBackend;
      mockApi.expectPOST('/api/v1/memberships.json').respond(422)
    }))

    it('should not add the resulting membership to the inbox upon failure', function(){
      scope.project = { id : 1 };
      scope.board = { id : 1 };
      scope.content = "I want to join this awesome project.";
      scope.sendRequest()

      mockApi.flush()
      expect(scope.inbox.length).toEqual(1)
    })
  })
})

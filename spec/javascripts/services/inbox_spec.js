describe("inbox", function(){
  beforeEach(module('app'))
  var ctrl, mockApi;

  beforeEach(inject(function($controller, $httpBackend){
    mockApi = $httpBackend;
    mockApi.expectGET('/api/v1/emails.json').respond(200,[
      {
        "user_id": 1,
        "project_id": 1,
        "text": "I want to join this awesome project.",
        "to_everyone": false
      }
      ])
  }))

  it('should give 1 email', inject(function(inbox){
    mockApi.flush();
    expect(inbox.inbox.history.length).toEqual(1);
  }))
})

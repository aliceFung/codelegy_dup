app.factory('profileRegistration', function(){
  var languages = ['Ruby', 'JavaScript', 'HTML', 'CSS', 'Ruby on Rails', 'AngularJS'];
  var expLevel = ['Beginner', 'Intermediate', 'Advanced', 'Expert'];

  var profileInput = {}; //{ languages: { name: '', expLevel: '' } };

  return {
    languages: languages,
    expLevel: expLevel,
    profileInput: profileInput
  }
})
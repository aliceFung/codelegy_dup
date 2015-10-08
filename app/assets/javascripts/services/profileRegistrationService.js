app.factory('ProfileRegistration', function(){

  // var languages = {1: 'Ruby/Rails',
  //                  2: 'JavaScript',
  //                  3: 'Python',
  //                  4: 'C',
  //                  5: 'Swift',
  //                  6: 'Java',
  //                  7: 'PHP' };

  var expLevel = {
    1: 'Beginner',
    2: 'Intermediate',
    3: 'Advanced',
    4: 'Expert',
  };

  var profileInput = { profile_languages: {} }; //{ languages: { name: '', expLevel: '' } };

  return {
    expLevel: expLevel,
    profileInput: profileInput
  };
});
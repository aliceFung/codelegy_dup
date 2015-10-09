app.factory('ProfileRegistration',
  ['Session', 'Restangular', function(Session, Restangular){

  var expLevel = {
    1: 'Beginner',
    2: 'Intermediate',
    3: 'Advanced',
    4: 'Expert',
  };

  var profileInput = { profile_languages: {} }; //{ languages: { name: '', expLevel: '' } };

  function update(user_id, profile, information){
    var profileInfo = {};
    // Send information to backend to update user profile
    profileInfo.user_id = user_id;
    // console.log(profileInfo.user_id);
    profileInfo.availability = profile.availability;
    profileInfo.about = profile.about;
    profileInfo.profile_languages_attributes = processProfileInput(profile.profile_languages);

    Restangular.all('profiles').customPUT({profile: profileInfo}).then(function(profile){
      // console.log('updated profile: ', profile);
      information.about = profile.about;
      information.availability = profile.availability;
      information.profile_languages_attributes = profile.profile_languages_attributes;
    }, function(error) {
      // console.log('cannot update profile');
    });
  }

  function processProfileInput(profileInput) {
    var count = 1;
    var result = {};
    for(var key in profileInput) {
      result[count] = {language_id: key, difficulty_id: profileInput[key]};
      count++;
    }
    return result;
  }

  return {
    expLevel: expLevel,
    profileInput: profileInput,
    update: update
  };


}]);
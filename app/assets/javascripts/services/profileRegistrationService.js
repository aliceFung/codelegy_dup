app.factory('ProfileRegistration',
  ['Session', 'Restangular', function(Session, Restangular){

  var expLevel = {
    1: 'Beginner',
    2: 'Intermediate',
    3: 'Advanced',
    4: 'Expert'
  };

  var profileInput = { profile_languages: {} }; //{ languages: { name: '', expLevel: '' } };

  function update(user_id, profile, information){
    var profileInfo = {};
    // Send information to backend to update user profile
    profileInfo.user_id = user_id;
    profileInfo.availability = profile.availability;
    profileInfo.about = profile.about;
    profileInfo.profile_languages_attributes = processProfileInput(profile.profile_languages);

    Restangular.all('profiles').customPUT({profile: profileInfo}).then(function(profile_returned){
      information.about = profile_returned.about;
      information.availability = profile_returned.availability;
      updateProfileLanguagesDisplayed(information.profile_languages, profile_returned.profile_languages);
    }, function(error) {
      alert('cannot update profile', error.data);
    });
  }

  function updateProfileLanguagesDisplayed(front_end_information, returned_profile_attr){
    for (var key in front_end_information) {
      delete front_end_information[key];
    }

    for(var newkey in returned_profile_attr){
      front_end_information[newkey] = returned_profile_attr[newkey];
    }
  }

  function processProfileInput(profileInput) {
    var count = 1;
    var result = {};
    for(var key in profileInput) {
      result[count] = {language_id: key, difficulty_id: profileInput[key][0], id: profileInput[key][1]};
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
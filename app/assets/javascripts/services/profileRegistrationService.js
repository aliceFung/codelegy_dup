app.factory('ProfileRegistration',
  ['Session', 'Restangular', function(Session, Restangular){

  var expLevel = {
    1: 'Beginner',
    2: 'Intermediate',
    3: 'Advanced',
    4: 'Expert'
  };

  var profileInput = { profile_languages: {} }; //{ languages: { name: '', expLevel: '' } };

  function update(user_id, profile, information, languageSelected){

    var profileInfo = {};

    // Send information to backend to update user profile
    profileInfo.user_id = user_id;
    profileInfo.availability = profile.availability;
    profileInfo.about = profile.about;
    profileInfo.profile_languages_attributes = processProfileInput(profile.profile_languages);  // need to clear profile

    Restangular.all('profiles').customPUT({profile: profileInfo}).then(function(profile_returned){
      // set returned about me and availability
      information.about = profile_returned.about;
      information.availability = profile_returned.availability;

      // update languages displayed
      updateProfileLanguagesDisplayed(information.profile_languages, profile_returned.profile_languages);
      // clear display of language selected to be added
      clearLanguageSelected(languageSelected);
    }, function(error) {

      alert('cannot update profile', error.data.error);
      clearLanguageSelected(languageSelected);

    });
  }

  function updateProfileLanguagesDisplayed(front_end_information, returned_profile_attr){
    clearObjectValues(front_end_information.profile_languages);

    for(var newkey in returned_profile_attr){
      front_end_information[newkey] = returned_profile_attr[newkey];
    }
  }

  function processProfileInput(profileInput) {
    var count = 1;
    var result = {};
    for(var key in profileInput) {
      result[count] = { language_id: key,
                        difficulty_id: profileInput[key][0],
                        id: profileInput[key][1],
                        _destroy: profileInput[key][2]};
      count++;
    }
    return result;
  }

  function clearLanguageSelected(languageSelected){
    clearObjectValues(languageSelected);
  }

  function clearObjectValues(object) {
    for (var key in object) {
      delete object[key];
    }
  }

  return {
    expLevel: expLevel,
    profileInput: profileInput,
    update: update
  };


}]);
app.factory('Timeslot', ['Restangular', function(Restangular){


  var addTimeslot = function(start_time, end_time, day){
    Restangular.all('timeslots').post({start: start_time, end: end_time, day: day})
  }

  var availabilityDays =  { Monday: false,
                            Tuesday: false,
                            Wednesday: false,
                            Thursday: false,
                            Friday: false,
                            Saturday: false,
                            Sunday: false,
                          }


  function processTimeslotInput(profileInput) {
    var count = 1;
    var result = {};
    for(var key in TimeslotInput) {
      result[count] = {};
      count++;
    }
    return result;
  }
  return {add: addTimeslot,
          days: availabilityDays}
}]);
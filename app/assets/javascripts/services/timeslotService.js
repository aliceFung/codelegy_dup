app.factory('Timeslot', ['Restangular', function(Restangular){


  var hours = ['1','2','3','4','5','6','7','8','9','10','11','12'];
  var minutes = ['00', '15', '30', '45'];
  var amPm = {'0':'AM', '1':'PM'};

  var timeslots = [];
  var startTime = {};
  var endTime = {};

  var availabilityDays =  { Monday: false,
                            Tuesday: false,
                            Wednesday: false,
                            Thursday: false,
                            Friday: false,
                            Saturday: false,
                            Sunday: false,
                          };


  function addDay(day){
    availabilityDays[day] = !availabilityDays[day];
  }

  function addTimeslot(){
    var start = _createTime(startTime);
    var end = _createTime(endTime);
    for (var day in availabilityDays){
      if (availabilityDays[day]){
        timeslots.push({day: day, start_time: start/1000, end_time: end/1000});
      }
    }
  }

  function _createTime(timeEntered){
    var min = timeEntered.minute * 60000;
    var hour = (timeEntered.hour * 3600000) + (12*3600000 * timeEntered.am);
    return (min + hour + (new Date(0)).getTimezoneOffset() * 60000);
  }

  return {add: addTimeslot,
          days: availabilityDays,
          hours: hours,
          minutes: minutes,
          amPm: amPm,
          all: timeslots,
          addDay: addDay,
          startTime: startTime,
          endTime: endTime};
}]);
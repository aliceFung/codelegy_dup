app.service('Availability', [function(){

  var hours = ['1','2','3','4','5','6','7','8','9','10','11','12'];
  var minutes = ['00', '15', '30', '45'];
  var amPm = {'0':'AM', '1':'PM'};

  return {
    hours : hours,
    minutes : minutes,
    amPm : amPm
  };

}]);
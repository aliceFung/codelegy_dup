app.filter('limitCharDisplayFilter', function(){

  return function(input){
    if (input.length > 50){
      return input.slice(0, 50) + "...";
    } else {
      return input;
    }
  }
});
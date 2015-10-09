app.directive("dashboardProgrammingLanguage",
  ['Restangular', 'Auth', 'Language',
    function(Restangular, Auth, Language){

  return {
    templateUrl: 'templates/dashboard/directives/programming-language.html',
    restrict: 'A',
    scope: true,
  };

}]);
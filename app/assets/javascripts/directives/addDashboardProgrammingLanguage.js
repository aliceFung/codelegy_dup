app.directive("addDashboardProgrammingLanguage",
  ['Restangular', 'Auth', 'Language',
    function(Restangular, Auth, Language){

  return {
    templateUrl: 'templates/dashboard/directives/programming-language-add.html',
    restrict: 'A',
    scope: true
  };

}]);
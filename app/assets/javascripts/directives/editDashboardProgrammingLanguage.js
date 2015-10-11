app.directive("editDashboardProgrammingLanguage",
  ['Restangular', 'Auth', 'Language',
    function(Restangular, Auth, Language){

  return {
    templateUrl: 'templates/dashboard/directives/programming-language-edit.html',
    restrict: 'A',
    scope: true
  };

}]);
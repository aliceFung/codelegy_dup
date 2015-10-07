app.factory('UserProjectService', ['Restangular',
  function(Restangular){

  console.log('UserProjectService initiated');

  var projects = [];

  Restangular.all('memberships').getList().then(
    function(result){
      projects.push.apply(projects, result);
    }
  );

  return {
    projects: projects
  };

}]);
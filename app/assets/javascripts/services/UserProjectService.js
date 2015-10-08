app.factory('UserProjectService', ['Restangular',
  function(Restangular){

  console.log('UserProjectService initiated');

  var projects = {};

  Restangular.one('memberships').get().then(
    function(result){
      // debugger;
      console.log('results', result);
      projects.project_membership = result.project_membership,
      projects.project_ownership = result.project_ownership;
    }
  );

  return {
    projects: projects
  };

}]);
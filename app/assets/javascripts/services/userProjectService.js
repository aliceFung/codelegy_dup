app.factory('userProjectService', ['Restangular',
  function(Restangular){

  // console.log('userProjectService initiated');

  var projectList = {};

  Restangular.one('memberships').get().then(
    function(result){
      // debugger;
      // console.log('results', result);
      projectList.projects = result; //array of projects
    }
  );

  return {
    projectList: projectList
  };

}]);
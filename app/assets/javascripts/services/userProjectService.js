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

  var update = function(project){
    params = {
      description: project.description,
      timeslots: project.timeslots,
      languages: project.languages,
      difficulty_id: project.difficulty_id
    }

    Restangular.one('projects', project.id).put(params)

  }

  return {
    projectList: projectList,
    update: update
  };

}]);
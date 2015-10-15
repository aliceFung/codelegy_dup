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
    obj = {
      description: project.description,
      timeslots: JSON.stringify(project.timeslots),
      languages: JSON.stringify(project.languages),
      difficulty_id: project.difficulty_id
    }
    // debugger
    return Restangular.one('projects', project.id).put(obj);
  }

  return {
    projectList: projectList,
    update: update
  };

}]);
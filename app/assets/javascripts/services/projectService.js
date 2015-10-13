app.factory('Project', ['Restangular', function(Restangular){

  var post = function(project, timeslots, languages){
    // console.log(project);
    // console.log('timeslots: ', timeslots);
    return Restangular.all('projects').post({ project: project,
                                              timeslots: timeslots,
                                              languages: languages});
  };

  var getPage = function(page){
    return Restangular.all('projects').getList({page: page});
  };

  return {post: post,
          getPage: getPage};
}]);

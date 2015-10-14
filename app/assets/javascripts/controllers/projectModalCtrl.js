app.controller("projectModalCtrl", ['$scope', 'userProjectService',
  function($scope, userProjectService){

  console.log('child ctrl', $scope.$parent.languages);

  console.log('langurls', $scope.project.language_urls);
  // $scope.list = {};
  $scope.languages = $scope.$parent.languages;
  $scope.projectLanguages = $scope.project.language_urls.map(function(val){return val.name});
  $scope.langHash = {};
  $scope.difficulties =[{name: 'Beginner', id: 1},
                        {name: 'Intermediate', id: 2},
                        {name: 'Advanced', id: 3},
                        {name: 'Expert', id: 4}];

  var difficulty_names = ['Beginner','Intermediate', 'Advanced', 'Expert']
  $scope.project.difficulty = {name: $scope.project.difficulty_name, id: difficulty_names.indexOf($scope.project.difficulty_name)+1};
  // var difficulty_id = $scope.difficulties.indexOf($scope.project.difficulty_name)+1;
  // // debugger;
  // $scope.project['difficulty_id'] = difficulty_id

  $scope.projectLanguages.forEach(function(val){
    $scope.langHash[val] = true;
  })

  // for(var j=0; j < $scope.projectLanguages.length; j++){
  //   selected = $.grep(, function(val){
  //     debugger;
  //     return val.name == $scope.languages[j].name;
  //   })
  // }
    // var idx = $scope.languages.indexOf(selected)
    // for(var i = 0; i < selected.length; i++){
    //   debugger;
    //   $scope.langHash[i] = true;
    // }
    // debugger;
  console.log('langHash', $scope.langHash);

  // $scope.list.projectList = userProjectService.projectList;

  // var getRectangularObj = function(membership_id){
  //   return Restangular.one('memberships', membership_id);
  // };

  // $scope.changeMembership = function(membership, project, accept){
  //   var membershipObj = getRectangularObj(membership.id);
  //   membershipObj.participant_type = accept ? 'member' : 'rejected';
  //   membershipObj.put().then( function(result){
  //     // console.log(result);
  //     if (membership.participant_type == 'pending'){
  //       project.pending_member_count--;
  //     }
  //     membership.participant_type = result.participant_type;
  //   } );
  // };

  // //can move method to emailService in future
  // $scope.sendMessage = function(project_id, msgSubject, msgBody){
  //   var msg = { subject: msgSubject,
  //               body: msgBody,
  //               project_id: project_id};
  //   Restangular.all('mailbox').post(msg).then(function(result){
  //     // console.log('success', result);
  //   }, function(error){
  //     // console.log('error', error);
  //   });
  // };



}]);
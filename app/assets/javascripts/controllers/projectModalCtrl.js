app.controller('projectModalCtrl', [
  '$scope', '$element', 'Restangular', 'project', 'projectList', 'idxInList', 'close',
  function($scope, $element, Restangular, project, projectList, idxInList, close) {


  $scope.project = project;
  // $scope.projectList = projectList;


  //  This close function doesn't need to use jQuery or bootstrap, because
  //  the button has the 'data-dismiss' attribute.
  $scope.close = function() {
    close({
      // not needed to send info back b/c databinding
      // card: $scope.card
    }, 500); // close, but give 500ms for bootstrap to animate
    console.log('close method ran');
  };

  //  This cancel function must use the bootstrap, 'modal' function because
  //  the doesn't have the 'data-dismiss' attribute.
  $scope.cancel = function() {

    //  Manually hide the modal.
    $element.modal('hide');

    //  Now call close, returning control to the caller.
    close({
    }, 500); // close, but give 500ms for bootstrap to animate
  };

  //================= project membership methods==================

  var getRectangularObj = function(membership_id){
    return Restangular.one('memberships', membership_id);
  };

  var updateMembership = function(index, status){
    var membership = $scope.project.memberships[idx]
    var membershipObj = getRectangularObj(membership.id);
    membershipObj.participation_type = status;
    membershipObj.put().then( function(result){
      console.log(result);
      if (membership.participation_type == 'pending'){
        membership.pending_member_count--;
      };
      membership.participation_type = result.participation_type;
    } );
  };

}]);
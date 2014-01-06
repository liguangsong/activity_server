function ActivityListController($scope, $navigate, $timeout) {
    if(Activity.get_all_activity(user.get_activity_of_user())==''){
        $navigate.go("/creat_activity")
    }
    $scope.eventList=Activity.get_all_activity(user.get_activity_of_user());
    $scope.jump_creat_activity = function () {
        $navigate.go("/creat_activity")
    }
    $scope.jump_auction = function (list) {
        var activity_name_apply = list.activity_name;
        Activity.create_now_activity(activity_name_apply);
        $navigate.go("/auction")

    }

}

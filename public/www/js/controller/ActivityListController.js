function ActivityListController($scope, $navigate, $http) {
    if (Activity.get_all_activity(user.get_activity_of_user()) == '') {
        $navigate.go("/creat_activity")
    }
    $scope.eventList = Activity.get_all_activity(user.get_activity_of_user());
    $scope.jump_creat_activity = function () {
        $navigate.go("/creat_activity")
    }
    $scope.jump_auction = function (list) {
        var activity_name_apply = list.activity_name;
        Activity.create_now_activity(activity_name_apply);
        $navigate.go("/auction")
    }
    $scope.synchronous_data = function () {
        var activity_of_user = user.get_activity_of_user();
        var user_name = user.get_user_name();
        $http({method: 'post', url: '/sessions/update', data: {update: activity_of_user, user: user_name}}).success(
            function (respond, statue) {
                if (respond == "true") {
                    $scope.notice = 'false'
                }
                if (respond == "false") {
                    $scope.notice = 'true'
                }
            })
            .error(function () {
                $scope.error = 'true'
            })
    }
}

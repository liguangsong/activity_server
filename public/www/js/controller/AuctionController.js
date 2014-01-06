function AuctionController($scope, $navigate, $timeout) {
    var activity_name_apply_start = Activity.current_activity();
    var apply_activity_name = Activity.get_now_activity_name();
    var status = Activity.get_activity_status(apply_activity_name);


    $scope.show=(status=="un_start");
    console.log(activity_name_apply_start!="")
    $scope.is_able=(status=="stop"||activity_name_apply_start!="");
    $scope.no_able=(status=="stop"||activity_name_apply_start=="");


    $scope.data_refresh = function () {
        $scope.newList2 = SignUp.render_sign_ups(apply_activity_name);
        $scope.number = $scope.newList2.length
    }
    $scope.jump_activity_list = function () {
        $navigate.go("/activity_list");
    }
    $scope.start_auction = function () {
        $scope.show = false;
        $scope.no_able=false;
        Activity.activity_status_change(apply_activity_name, "start");
        Activity.create_activity_start(apply_activity_name);
    }
    $scope.stop_auction = function () {
        var r = confirm('确定要结束本次活动吗？');
        if (r == true) {
            Activity.activity_status_change(apply_activity_name, "stop");
            Activity.destroy_activity_start();
            $navigate.go("/auction_list");
        }
    }
    $scope.go_to_auction_list = function () {
        if (Activity.get_activity_status(apply_activity_name) == "stop"||activity_name_apply_start==null) {
            $navigate.go("/auction_list")
        }
    }
    $scope.data_refresh();


}
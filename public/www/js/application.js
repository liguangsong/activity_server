var myModule = angular.module('myApp', ['mobile-navigate']);

myModule.run(function ($route, $http, $templateCache) {
    angular.forEach($route.routes, function (r) {
        if (r.templateUrl) {
            $http.get(r.templateUrl, {cache: $templateCache});
        }
    });
});

myModule.controller('MainCtrl', function ($scope, $navigate) {
    $scope.$navigate = $navigate;
});

myModule.directive('ngTap', function () {
    var isTouchDevice = !!("ontouchstart" in window);
    return function (scope, elm, attrs) {
        if (isTouchDevice) {
            var tapping = false;
            elm.bind('touchstart', function () {
                tapping = true;
            });
            elm.bind('touchmove', function () {
                tapping = false;
            });
            elm.bind('touchend', function () {
                tapping && scope.$apply(attrs.ngTap);
            });
        } else {
            elm.bind('click', function () {
                scope.$apply(attrs.ngTap);
            });
        }
    };
});


var native_access;
$(document).ready(function () {


    native_access = new NativeAccess();


});


//////
//var native_accessor = {
//    process_received_message: function (json_message) {
//        judge_and_process_received_apply_message(json_message);
//    },
//
//    send_sms: function (phone, message) {
//
//        native_access.send_sms({"receivers": [
//            {"name": 'name', "phone": phone}
//        ]}, {"message_content": message});
//    },
//
//    receive_message: function (json_message) {
//
//        if (typeof this.process_received_message === 'function') {
//
//            this.process_received_message(json_message);
//        }
//    }
//};


//function judge_and_process_received_apply_message(json_message) {
//    var temp_message = json_message.messages[0].message;
//    if (temp_message.substr(0, 2).toUpperCase() == 'BM') {
//        SMS.sign_up_is_or_no_fail(json_message);
//    }
//    if(temp_message.substr(0,2).toUpperCase()=="JJ"){
//        SMS.is_price_or_not(json_message);
//    }
//}
//
//go_to_act_detail_page_by_name_of = function (act_name) {
//    var page_jump_or_not = document.getElementById(act_name)
//    if (page_jump_or_not) {
//        var scope = angular.element(page_jump_or_not).scope();
//        scope.$apply(function () {
//            scope.data_refresh();
//        })
//    }
//}
$(document).ready(function() {
	$('.onboarding-modal').modal('show');
  	$('#rootwizard').bootstrapWizard({onTabShow: function(tab, navigation, index) {
		var $total = navigation.find('li').length;
		var $current = index+1;
		var $percent = ($current/$total) * 100;
		$('#rootwizard').find('.bar').css({width:$percent+'%'});
		if($current >= $total) {
			$('#rootwizard').find('.pager .next').hide();
			$('#rootwizard').find('.pager .finish').show();
			$('#rootwizard').find('.pager .finish').removeClass('disabled');
		} else {
			$('#rootwizard').find('.pager .next').show();
			$('#rootwizard').find('.pager .finish').hide();
		}
	}});
});
var onboardingApp = angular.module('onboardingApp', []);

onboardingApp.controller('TeamCtrl', function ($scope, $http) {
  $http.get('/assets/teamdata.json').success(function(data){
    $scope.teams = data;
  });
  

});


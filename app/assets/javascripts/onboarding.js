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
var onboardingApp = angular.module('onboardingApp',['ngResource','ngAnimate']);

onboardingApp.controller('TeamCtrl', function($scope, $resource) {
	Team = $resource('/teams/:id', {id: '@id'})
	$scope.teams = Team.query();
	});

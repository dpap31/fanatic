
// Update Profile Teams	Token Selector
$(document).ready(function() {
	$('select#user_team_ids_').select2({
		dropdownCssClass: "bigdrop",
		maximumSelectionSize: 5
	});

	// Client side validation
	$('#edit_user_2').bootstrapValidator({
		message: 'This value is not valid',
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		}
	});
});



var onboardingApp = angular.module('userSearchApp',['ngResource','ngAnimate']);

onboardingApp.controller('UserCtrl', function($scope, $resource) {
	User = $resource('/users/:id.json', {id: '@id'})
	$scope.users = User.query();
	});



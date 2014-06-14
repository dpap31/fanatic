
// Update Profile Teams	Token Selector
$(document).ready(function() {
	$('select#user_team_ids_').select2({
		dropdownCssClass: "bigdrop",
	});
});

var onboardingApp = angular.module('userSearchApp',['ngResource','ngAnimate']);

onboardingApp.controller('UserCtrl', function($scope, $resource) {
	User = $resource('/users/:id.json', {id: '@id'})
	$scope.users = User.query();
	});

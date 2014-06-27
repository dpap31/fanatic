
// Update Profile Teams	Token Selector
$(document).ready(function() {
	$('select#user_team_ids_').select2({
		dropdownCssClass: "bigdrop",
		maximumSelectionSize: 5
	});

function IsEmail(email) {
  var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
  return regex.test(email);
}
});


var onboardingApp = angular.module('userSearchApp',['ngResource','ngAnimate']);

onboardingApp.controller('UserCtrl', function($scope, $resource) {
	User = $resource('/users/:id.json', {id: '@id'})
	$scope.users = User.query();
	});



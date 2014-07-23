
// Update Profile Teams	Token Selector
$(document).ready(function() {
	$('.best_in_place').best_in_place();
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
		},
		threshold: 3,
		fields: {
			'user[first_name]': {
				validators: {
					notEmpty: {
						message: 'First name is required'
					}
				}
			},
			'user[last_name]': {
				validators: {
					notEmpty: {
						message: 'Last name is required'
					}
				}
			},
			'user[email]': {
                validators: {
                    notEmpty: {
                        message: 'The email is required and cannot be empty'
                    },
                    emailAddress: {
                        message: 'The input is not a valid email address'
                    }
                }
            },
		   'user[username]': {
                message: 'The username is not valid',
                validators: {
                    notEmpty: {
                        message: 'The username is required and cannot be empty'
                    },
                    stringLength: {
                        min: 4,
                        max: 30,
                        message: 'The username must be more than 4 and less than 30 characters long'
                    },
                    regexp: {
                        regexp: /^[a-zA-Z0-9_]+$/,
                        message: 'The username can only consist of alphabetical, number and underscore'
                    }
                }
            }
        }
	});
});



var onboardingApp = angular.module('userSearchApp',['ngResource','ngAnimate']);

onboardingApp.controller('UserCtrl', function($scope, $resource) {
	User = $resource('/users/:id.json', {id: '@id'})
	$scope.users = User.query();
	});



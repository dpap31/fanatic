$(document).ready(function() {
	$('select#user_team_ids_').select2({
		dropdownCssClass: "bigdrop",
		maximumSelectionSize: 5
	});
	$('.onboarding-modal').modal('show');
	$('.edit_user').bootstrapValidator({
		message: 'This value is not valid',
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok ',
			invalid: 'glyphicon glyphicon-remove ',
			validating: 'glyphicon glyphicon-refresh '
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
            },
		}
	});
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
	$('#form_submit').on('click', function(e) {
      $('.edit_user').bootstrapValidator('defaultSubmit');
    });
});

var onboardingApp = angular.module('onboardingApp',['ngResource','ngAnimate']);

onboardingApp.controller('TeamCtrl', function($scope, $resource) {
	Team = $resource('/teams/:id', {id: '@id'})
	$scope.teams = Team.query();
	});
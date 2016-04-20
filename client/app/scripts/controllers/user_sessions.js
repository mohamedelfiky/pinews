/**
 * Created by mohamed on 18/04/16.
 */
(function () {
  'use strict';

  /**
   * @ngdoc function
   * @name fakeLunchHubApp.controller:UserSessionsCtrl
   * @description
   * # UserSessionsCtrl
   * Controller of the fakeLunchHubApp
   */
  angular.module('pinewsApp')
    .controller('UserSessionsCtrl', userSessionsCtrl);


  userSessionsCtrl.$inject = ['$auth', 'logger', '$scope', "$state"];
  function userSessionsCtrl($auth, logger, $scope, $state) {
    var session = this;

    $scope.$on('auth:login-success', function (e) {
      logger.success('success login');
      $state.go('admin.dashboard');
    });

    $scope.$on('auth:login-error', function (e) {
      logger.error('login failure');
    });

    $scope.$on('auth:registration-email-success', function (e) {
      logger.success('registration success');
    });

    $scope.$on('auth:registration-email-error', function (e) {
      logger.error('registration failure');
    });


    $scope.$on('auth:session-expired', function (ev) {
      logger.error(JSON.stringify(ev));
    });

    $scope.$on('auth:email-confirmation-success', function (ev, user) {
      alert("Welcome, " + user.email + ". Your account has been verified.");
    });
  }
}());
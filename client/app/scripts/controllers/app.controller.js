/**
 * Created by mohamed on 18/04/16.
 */
(function () {
  'use strict';

  /**
   * @ngdoc function
   * @name pinewsApp.controller:AppCtrl
   * @description
   * # AppCtrl
   * Controller of the pinewsApp
   */
  angular.module('pinewsApp')
    .controller('AppCtrl', appCtrl);


  appCtrl.$inject = ['$auth', 'logger', '$scope', "$state"];
  function appCtrl($auth, logger, $scope, $state) {
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

    $scope.$on('auth:logout-success', function (ev) {
      logger.success('logout-success');
      $state.go('home');
    });

    $scope.$on('auth:logout-error', function (ev) {
      logger.error('session expired');
      $state.go('sign_in')
    });

    $scope.$on('auth:session-expired', function (ev) {
      logger.error(JSON.stringify(ev));
    });

    $scope.$on('auth:email-confirmation-success', function (ev, user) {
      alert("Welcome, " + user.email + ". Your account has been verified.");
    });
  }
}());

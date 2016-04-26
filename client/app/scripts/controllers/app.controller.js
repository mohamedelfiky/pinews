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

  appCtrl.$inject = ['$auth', 'logger', '$scope', '$state'];

  function appCtrl($auth, logger, $scope, $state) {
    $scope.$on('auth:login-success', function () {
      logger.success('success login');
      $state.go('admin.dashboard');
    });

    $scope.$on('auth:login-error', function () {
      logger.error('login failure');
    });

    $scope.$on('auth:registration-email-success', function () {
      logger.success('registration success');
    });

    $scope.$on('auth:registration-email-error', function () {
      logger.error('registration failure');
    });

    $scope.$on('auth:logout-success', function () {
      logger.success('logout-success');
      $state.go('home');
    });

    $scope.$on('auth:logout-error', function () {
      logger.error('session expired');
      $state.go('sign_in');
    });

    $scope.$on('auth:session-expired', function (ev) {
      logger.error(JSON.stringify(ev));
    });

    $scope.$on('auth:email-confirmation-success', function (ev, user) {
      logger.info('Welcome, ' + user.email + '. Your account has been verified.');
    });
  }
}());

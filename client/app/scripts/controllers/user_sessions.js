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


  userSessionsCtrl.$inject = ['$auth', 'logger'];
  function userSessionsCtrl($auth, logger) {
    var session= this;

    session.handleLoginBtnClick = function () {
      $auth.submitLogin(session.loginForm)
        .then(function (resp) {
          logger.success(JSON.stringify(resp));
        })
        .catch(function (resp) {
          logger.error(JSON.stringify(resp));
        });
    };


  }
}());

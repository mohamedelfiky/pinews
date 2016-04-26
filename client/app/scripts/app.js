(function () {
  'use strict';


  /**
   * @ngdoc overview
   * @name pinewsApp
   * @description
   * # pinewsApp
   *
   * Main module of the application.
   */
  angular
    .module('pinewsApp', [
      'ngAnimate',
      'ngAria',
      'ngCookies',
      'ngMessages',
      'ngResource',
      'ngRoute',
      'ngSanitize',
      'ngTouch',
      'ng-token-auth',
      'ui.materialize',
      'ngFileUpload',
      'ui.router'
    ])
    .config(function ($authProvider) {
      $authProvider.configure({
        apiUrl: 'http://localhost:9000/api/v1',
        validateOnPageLoad: false,
        storage: 'cookies'
      });


    });


}());

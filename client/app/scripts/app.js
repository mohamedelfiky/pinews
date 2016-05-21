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
      'ui.router',
      'infinite-scroll',
      'config'
    ])
    .config(function ($authProvider, ENV) {
      $authProvider.configure({
        apiUrl: ENV.apiEndpoint,
        validateOnPageLoad: true,
        storage: 'cookies'
      });
    });

}());

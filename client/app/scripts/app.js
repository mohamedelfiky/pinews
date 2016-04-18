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
    'ng-token-auth'
  ])
  .config(function($authProvider) {
    $authProvider.configure({
      apiUrl: 'http://localhost:9000/api/v1'
    });
  })
  .config(function ($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'views/main.html',
        controller: 'MainCtrl',
        controllerAs: 'main'
      })
      .when('/about', {
        templateUrl: 'views/about.html',
        controller: 'AboutCtrl',
        controllerAs: 'about'
      })
      .when('/sign_in', {
        templateUrl: 'views/user_sessions/new.html',
        controller: 'UserSessionsCtrl',
        controllerAs: 'loginForm'
      })
      .otherwise({
        redirectTo: '/'
      });
  });

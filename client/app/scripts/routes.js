/**
 * Created by mohamed on 19/04/16.
 */
(function () {
  'use strict';

  angular.module('pinewsApp').config(routesConfig);

  routesConfig.$inject = ["$stateProvider", "$urlRouterProvider"];

  function routesConfig($stateProvider, $urlRouterProvider) {
    $urlRouterProvider.otherwise("/");

    $stateProvider
      .state('home', {
        url: '/',
        templateUrl: 'views/main.html',
        controller: 'MainCtrl',
        controllerAs: 'main'
      })
      .state('about', {
        url: '/about',
        templateUrl: 'views/about.html',
        controller: 'AboutCtrl',
        controllerAs: 'about'
      })
      .state('details', {
        url: '/details/:id/:title',
        templateUrl: 'views/details.html',
        controller: 'DetailsCtrl',
        controllerAs: 'details'
      })
      .state('sign_in', {
        url: '/sign_in',
        templateUrl: 'views/user_sessions/new.html',
        controller: 'UserSessionsCtrl',
        controllerAs: 'loginForm'
      })
      .state('register', {
        url: '/register',
        templateUrl: 'views/user_sessions/create.html',
        controller: 'UserSessionsCtrl',
        controllerAs: 'registrationForm'
      })
      .state('admin', {
        url: '/admin',
        abstract: true,
        template: '<ui-view/>',
        controller: 'AppCtrl',
        resolve: {
          auth: function ($auth, logger, $state) {
            return $auth.validateUser()
              .catch(function (resp) {
                logger.error(resp.errors[0]);
                $state.go('home');
              });
          }
        }
      })
      .state('admin.articles', {
        url: '/articles',
        templateUrl: 'views/admin/articles/list.html',
        controller: 'ArticlesCtrl',
        controllerAs: 'vm'
      })
      .state('admin.dashboard', {
        url: '/dash',
        templateUrl: 'views/admin/dash.html',
        controller: 'AdminDashCtrl'
      });


  }
}());

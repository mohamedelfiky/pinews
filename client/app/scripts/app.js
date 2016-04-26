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
    .config(function ($authProvider, $httpProvider) {
      $authProvider.configure({
        apiUrl: 'http://localhost:9000/api/v1',
        validateOnPageLoad: true
      });

      $httpProvider.interceptors.push(function ($injector) {
        return {
          'request': function (config) {
            if (config.url.indexOf('/api/v1/articles') >= 0) {
              $injector.invoke(['$auth', function ($auth) {
                var headers = $auth.retrieveData('auth_headers');
                if (headers) {
                  for (var key in headers) {
                    config.headers[key] = headers[key];
                  }
                }
              }]);
            }
            return config;
          }
        };
      });
    });


}());

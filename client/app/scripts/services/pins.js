(function () {
  'use strict';

  /**
   * @ngdoc service
   * @name pinewsApp.articles
   * @description
   * # articles
   * Factory in the pinewsApp.
   */
  angular.module('pinewsApp')
    .factory('Pin', pinService);

  pinService.$inject = ['$resource', 'ENV'];

  function pinService($resource, ENV) {
    return $resource(ENV.API_BASE_URL + 'articles/:articleId/pins/:id', null,
      {
        'count': {method: 'GET'}
      });
  }
}());

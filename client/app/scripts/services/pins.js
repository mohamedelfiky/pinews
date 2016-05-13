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

  pinService.$inject = ['$resource', 'config'];

  function pinService($resource, config) {
    return $resource(config.API_BASE_URL + 'articles/:articleId/pins/:id', null,
      {
        'count': {method: 'GET'}
      });
  }
}());

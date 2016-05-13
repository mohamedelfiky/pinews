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
    .factory('Article', articleService);

  articleService.$inject = ['$resource', 'config'];

  function articleService($resource, config) {
    return $resource(config.API_BASE_URL + 'articles/:id', null,
      {
        'update': { method:'PUT' }
      });
  }
}());

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

  articleService.$inject = ['$resource', 'ENV'];

  function articleService($resource, ENV) {
    return $resource(ENV.API_BASE_URL + 'articles/:id', null,
      {
        'update': { method:'PUT' }
      });
  }
}());

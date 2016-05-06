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

  articleService.$inject = ['$resource'];

  function articleService($resource) {
    return $resource('/api/v1/articles/:id', null,
      {
        'update': { method:'PUT' }
      });
  }
}());

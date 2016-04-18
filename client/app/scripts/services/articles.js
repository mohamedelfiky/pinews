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
    .factory('article', articleService);

  articleService.$inject = ['$resource'];
  function articleService($resource) {
    return $resource('/api/v1/articles/:id');
  }
}());

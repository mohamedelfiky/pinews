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

  articleService.$inject = ['$resource', '$http'];
  function articleService($resource, $http) {
    return $resource('/api/v1/articles/:id');
  }
}());

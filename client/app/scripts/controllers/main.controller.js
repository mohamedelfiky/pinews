(function () {
  'use strict';

  /**
   * @ngdoc function
   * @name pinewsApp.controller:MainCtrl
   * @description
   * # MainCtrl
   * Controller of the pinewsApp
   */
  angular.module('pinewsApp')
    .controller('MainCtrl', mainController);

  mainController.$inject = ['Article', 'logger'];

  function mainController(Article, logger) {
    var vm = this;  // jshint ignore:line

    vm.loadArticles = function () {
      Article.query(function (articles) {
        vm.articles = articles;
      });
    };

    vm.pinArticle = function (article) {
      logger.success(article.title);
    };

  }


}());

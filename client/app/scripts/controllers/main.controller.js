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

  mainController.$inject = ["article", "logger"];

  function mainController(article, logger) {
    var vm = this;
    article.query(function (articles) {
      vm.articles = articles;
      logger.success(articles.length + " Articles");
    });
  }


}());

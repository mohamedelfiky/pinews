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

  mainController.$inject = ["article", "exception", "logger"];

  function mainController(article, exception, logger) {

    article.query(function (articles) {
      logger.success(articles);
    });

  }


}());

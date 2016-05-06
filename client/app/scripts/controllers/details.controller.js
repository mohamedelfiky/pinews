
(function () {
  'use strict';

  /**
   * @ngdoc function
   * @name pinewsApp.controller:DetailsCtrl
   * @description
   * # DetailsCtrl
   * Controller of the pinewsApp
   */
  angular.module('pinewsApp')
    .controller('DetailsCtrl', detailsController);

  detailsController.$inject = ['logger', 'Article', '$state'];

  function detailsController(logger, Article, $state) {

    var vm = this; // jshint ignore:line

    vm.article = {};


    vm.loadArticle = function () {
      Article.get({id: $state.params.id}, function (res) {
        vm.article = res;
      });
    };
  }

}());

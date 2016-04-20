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

  detailsController.$inject = ["logger", "article", "$state"];
  function detailsController(logger, article, $state) {

    var vm = this;
    vm.article = {};
    article.get({id: $state.params.id}, function (res) {
      vm.article = res;
    });

  }

}());

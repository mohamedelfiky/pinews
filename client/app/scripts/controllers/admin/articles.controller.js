/**
 * Created by mohamed on 19/04/16.
 */
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
    .controller('ArticlesCtrl', articlesController);

  articlesController.$inject = ["logger", "article", "$state", "$timeout", "$scope"];
  function articlesController(logger, Article, $state, $timeout, $scope) {

    var vm = this;
    vm.articles = [];
    vm.pagenation = false;
    vm.page = 1;
    loadPage(1);

    vm.loadPage = loadPage;
    vm.edit = editArticle;
    vm.selectedArticle = false;
    vm.openRemovePopup = openRemovePopup;
    vm.reloadCurrentPage = reloadCurrentPage;

    function loadPage(page) {
      Article.query({page: page}, function (articles, headers) {
        vm.pagenation = JSON.parse(headers("X-Pagination"));
        vm.articles = articles;
        vm.page = page;
      });
    }

    function reloadCurrentPage() {
      loadPage(vm.page);
    }

    function openRemovePopup(article) {
      vm.selectedArticle = article;
      $timeout(function () {
        $('#deleteModal').openModal();
      });
    }

    $scope.$on("reload_articles",function(){
      reloadCurrentPage();
    });

    function editArticle(article) {
      alert(article.title);
    }
  }

}());

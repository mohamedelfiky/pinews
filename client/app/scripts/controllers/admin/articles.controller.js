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

  articlesController.$inject = ["logger", "article", "Upload", "$timeout", "$scope"];
  function articlesController(logger, Article, Upload, $timeout, $scope) {

    var default_article = {name: '', description: '', image: ''};
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
    vm.addNewArticle = addNewArticle;

    function loadPage(page) {
      Article.query({page: page}, function (articles, headers) {
        vm.pagenation = JSON.parse(headers("X-Pagination"));
        vm.articles = articles;
        vm.page = page;
      });
    }

    function reloadCurrentPage() {
      loadPage(vm.page);
      vm.selectedArticle = default_article;
    }


    function addNewArticle() {
      vm.selectedArticle = default_article;

      $timeout(function () {
        $('#newModal').openModal();
      });
    }

    function openRemovePopup(article) {
      vm.selectedArticle = article;
      $timeout(function () {
        $('#deleteModal').openModal();
      });
    }


    $scope.$on("update-article", function (event, args) {
      vm.upload(
        args.article,
        {method: 'PUT', url: '/api/v1/articles/' + args.article.id + '.json'},
        function () {
          logger.success("Article Created");
          reloadCurrentPage();
        }
      );
    });

    $scope.$on("create-article", function (event, args) {
      vm.upload(
        args.article,
        {method: 'POST', url: '/api/v1/articles.json'},
        function () {
          logger.success("Article Created");
          reloadCurrentPage();
        }
      );
    });


    vm.upload = function (article, request, successCallback) {
      Upload.upload({
        url: request.url,
        method: request.method,
        headers: {'Content-Type': false},
        fields: {
          article: article
        },
        file: article.image,
        sendFieldsAs: 'json'
      }).then(function (resp) {
        console.log('Success ' + resp.config.file.name + 'uploaded. Response: ' + resp.data);
        successCallback();
      }, function (resp) {
        logger.error('Error status: ' + resp.status);
      }, function (evt) {
        var progressPercentage = parseInt(100.0 * evt.loaded / evt.total);
        console.log('progress: ' + progressPercentage + '% ' + evt.config.file.name);
      });
    };

    $scope.$on("delete-article", function (event, args) {
      Article.delete({id: args.article.id}, function (article) {
        logger.success("Article Deleted");
        reloadCurrentPage();
      });
    });

    function editArticle(article) {
      vm.selectedArticle = article;
      $timeout(function () {
        $('#editModal').openModal();
      });
    }
  }

}());

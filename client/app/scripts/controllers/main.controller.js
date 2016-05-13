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

  mainController.$inject = ['Article', 'Pin', 'logger'];

  function mainController(Article, Pin, logger) {
    var vm = this;  // jshint ignore:line

    // init!
    vm.page = 1;
    vm.articles = [];
    vm.pagination = false;
    vm.itemsPerPage = 5;
    vm.busy = false;
    vm.needToLoadMore = false;


    vm.loadArticles = function (page) {
      if (vm.pagination === false || vm.pagination.lastPage === false) {
        Article.query({page: page}, function (articles, headers) {
          vm.articles = vm.articles.concat(articles);
          vm.pagination = JSON.parse(headers('X-Pagination'));
          vm.page = vm.pagination.nextPage;

          if (articles && articles.length < vm.itemsPerPage) {
            vm.done = true;
          }
          vm.lastIndex = vm.articles.length;
          vm.loading = false;
        });
      }
    };


    /* show more of currently loaded data */
    vm.showMore = function () {

      if (!vm.busy) {
        vm.loadArticles(vm.page);
        setTimeout(function () {
          vm.busy = false;
          vm.needToLoadMore = vm.pagination.lastPage;
        }, 300);
        vm.busy = true;
      }
    };

    vm.pinArticle = function (article) {
      new Pin({}).$save({articleId: article.id}).then(function () {
        logger.success('Pined to your favourites..');
      }, function (err) {
        if (err.status === 401){
          logger.error('Please login or register <br/> to pin your favorite Articles');
        }else{
          logger.error(err.data.errors[Object.keys(err.data.errors)[0]][0]);
        }
      });

    };
  }

}());

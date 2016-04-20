(function () {
  'use strict';

  /**
   * @ngdoc directive
   * @name pinewsApp.directive:modal
   * @description
   * # modal
   */
  angular.module('pinewsApp')
    .directive('pinModal', pinModal);
  pinModal.$inject = ["article", "logger", "$rootScope"];
  function pinModal( Article, logger, $rootScope) {
    return {
      templateUrl: 'views/shared/modal.directive.html',
      restrict: 'E',
      scope: {
        article: '=',
        modalId: '@'
      },
      link: function postLink(scope, element, attrs) {
        scope.closeModal = function (success) {
          if (success) {
            Article.delete({id: scope.article.id}, function (article) {
              logger.success('Article deleted');
              $rootScope.$broadcast("reload_articles");
            });
          }
          $('#' + scope.modalId).closeModal();
          $('.lean-overlay').remove();

        };
      }
    };
  }
}());

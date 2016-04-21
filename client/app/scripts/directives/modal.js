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
  pinModal.$inject = ["article", "Upload", "$rootScope"];
  function pinModal(Article, Upload, $rootScope) {
    return {
      templateUrl: 'views/shared/modal.directive.html',
      restrict: 'E',
      scope: {
        article: '=',
        modalId: '@',
        title: '=',
        broadcast: '@',
        template: '=',
        templateUrl: '@'
      },
      link: function postLink(scope, element, attrs) {
        $(document).on('click', '.lean-overlay', function () {
          $('.lean-overlay').remove();
        });

        scope.selectFile = function (f) {
          scope.article.image = f;
        };


        scope.closeModal = function (success) {
          if (success) {
            $rootScope.$broadcast(scope.broadcast, {article: scope.article});
          }
          $('#' + scope.modalId).closeModal();
          $('.lean-overlay').remove();

        };
      }
    };
  }
}());

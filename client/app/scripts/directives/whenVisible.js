'use strict';

/**
 * @ngdoc directive
 * @name pinewsApp.directive:whenScrolled
 * @description
 * # whenScrolled
 */
angular.module('pinewsApp')
  .directive('whenVisible', function() {

    function isScrolledIntoView(elem)
    {
      var docViewTop = $(window).scrollTop();
      var docViewBottom = docViewTop + ($(window).outerHeight());
      var elemTop = elem.offset().top;

      return (elemTop <= docViewBottom) && (elemTop > docViewTop);
    }

    return function(scope, elm, attr) {
      $(window).scroll(function(){
        if (isScrolledIntoView(elm)) {
          //console.log("in view!!" + scope.busy);
          elm.addClass('animated');

          if (!scope.busy){
            setTimeout(function(){
              scope.$apply(attr.whenVisible);
            });
          }
        }
        else {
          elm.removeClass('animated');
        }
        return false;
      });
    };
  });

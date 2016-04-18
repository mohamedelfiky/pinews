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

mainController.$inject = ["article"];

function mainController(article) {
  this.awesomeThings = [
    'HTML5 Boilerplate',
    'AngularJS',
    'Karma'
  ];

  article.query(function(articles) {
    console.log(articles);
  });


}

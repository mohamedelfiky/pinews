'use strict';

describe('Controller: UserSessionsCtrl', function () {

  // load the controller's module
  beforeEach(module('pinewsApp'));

  var UserSessionsCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    UserSessionsCtrl = $controller('UserSessionsCtrl', {
      $scope: scope
      // place here mocked dependencies
    });
  }));


});

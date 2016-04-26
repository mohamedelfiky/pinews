'use strict';

describe('Controller: AdminDashCtrl', function () {

  // load the controller's module
  beforeEach(module('pinewsApp'));

  var AdminDashCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    AdminDashCtrl = $controller('AdminDashCtrl', {
      $scope: scope
      // place here mocked dependencies
    });
  }));


});

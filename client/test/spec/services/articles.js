'use strict';

describe('Service: Article', function () {

  // load the service's module
  beforeEach(module('pinewsApp'));

  // instantiate service
  var articles;
  beforeEach(inject(function (_Article_) {
    articles = _Article_;
  }));

  it('should do something', function () {
    expect(!!articles).toBe(true);
  });

});

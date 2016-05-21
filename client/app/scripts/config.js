(function () { 
 "use strict";

 angular.module('config', [])

.constant('ENV', {name:'development',apiEndpoint:'http://localhost:9000/api/v1',API_BASE_URL:'/api/v1/'})

; 
}());
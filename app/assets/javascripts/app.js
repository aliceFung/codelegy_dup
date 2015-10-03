var app = angular.module('app', ['ui.router', 'restangular'])

// .config(["RestangularProvider", function(RestangularProvider){
//   RestangularProvider.setBaseUrl("/api/v1")
//   RestangularProvider.setRequestSuffix(".json")

// }])


.config(['$stateProvider', '$urlRouterProvider',
  function($stateProvider, $urlRouterProvider){
    $urlRouterProvider.otherwise('/');

    $stateProvider
      .state('home', {
        url: '/',
        views: {
        'layout': {templateUrl: 'templates/sign-up.html'},
  
        'navbar': {templateUrl: 'templates/header-1.html'}
        }
      })


  }]);

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
        '': {templateUrl: 'templates/home.html'},
  
        'navbar': {templateUrl: 'templates/header-1.html'}
        }
      })
      .state('home.signup',{
        url:'signup',
        templateUrl: 'templates/signup.html'
      })
      .state('home.login', {
            url: 'login',
            templateUrl: 'templates/login.html'
      });


  }]);

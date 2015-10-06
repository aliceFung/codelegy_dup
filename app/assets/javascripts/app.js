var app = angular.module('app', ['ngAnimate','ui.router', 'restangular', 'Devise'])

// .config(["RestangularProvider", function(RestangularProvider){
//   RestangularProvider.setBaseUrl("/api/v1")
//   RestangularProvider.setRequestSuffix(".json")

// }])

.config(["AuthProvider", function(AuthProvider) {
  AuthProvider.loginPath('/users/sign_in.json');
  AuthProvider.loginMethod('POST');
  AuthProvider.logoutPath('/users/sign_out.json');
  AuthProvider.logoutMethod('DELETE');
}])

.config(["RestangularProvider", function(RestangularProvider) {
  RestangularProvider.setBaseUrl('/api/v1');
  RestangularProvider.setRequestSuffix('.json');
}])

.config(['$stateProvider', '$urlRouterProvider',
  function($stateProvider, $urlRouterProvider){
    $urlRouterProvider.otherwise('/');

    $stateProvider
      .state('home', {
        url: '/',
        views: {
        '': {templateUrl: 'templates/home.html'},

        'navbar': {
                templateUrl: 'templates/header-1.html',
                controller: 'sessionCtrl'
            }

        }
      })
      // nested routes for our home page

      .state('home.login', {
            url: 'login',
            templateUrl: 'templates/login.html',
            controller: 'sessionCtrl'
      })
        // route to show our basic form (/form)
        .state('home.form', {
            url: '/form',
            templateUrl: 'templates/registration/form.html',
            controller: 'signUpCtrl'
        })

        // nested states  for our form
        .state('home.form.profile', {
            url: '/profile',
            templateUrl: 'templates/registration/form-profile.html',
            controller: 'profileRegistrationCtrl'
        })

        // url will be /form/interests
        .state('home.form.languages', {
            url: '/languages',
            templateUrl: 'templates/registration/form-lang.html',
            controller: 'profileRegistrationCtrl'
        })

        // url will be /form/payment
        .state('home.form.availability', {
            url: '/availability',
            templateUrl: 'templates/registration/form-availability.html',
            controller: 'signUpCtrl'
        });


    $stateProvider
      .state('projects', {
        url: '/projects',
        resolve: {
            projects: [ 'Restangular', function(Restangular){
                        return Restangular.all('projects').getList()
                        .then(function(response){
                            return response
                        }, function(error){
                            return error
                        })
                      }]
         },
        views: {
        '': {
              templateUrl: 'templates/projects/index.html',
              controller: 'projectsCtrl',
            },

        'navbar': {
            templateUrl: 'templates/header-1.html',
            controller: 'sessionCtrl'
        }

        }
      })
      .state('projects.new', {
        url: '/new',
        // resolve: {
        //     projects: [ 'Restangular', function(Restangular){
        //                 return Restangular.all('projects').getList()
        //                 .then(function(response){
        //                     return response
        //                 }, function(error){
        //                     return error
        //                 })
        //               }]
        //  },
        views: {
        '': {
              templateUrl: 'templates/projects/new.html',
            },

        'navbar': {
            templateUrl: 'templates/header-1.html',
            controller: 'sessionController'
        }

        }
      })

  }]);

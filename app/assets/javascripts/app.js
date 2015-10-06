var app = angular.module('app', ['ngAnimate','ui.router', 'restangular', 'Devise'])

// .config(["RestangularProvider", function(RestangularProvider){
//   RestangularProvider.setBaseUrl("/api/v1")
//   RestangularProvider.setRequestSuffix(".json")

// }])

.config(function(AuthProvider) {
    AuthProvider.loginPath('/users/sign_in.json');
    AuthProvider.loginMethod('POST');
    AuthProvider.logoutPath('/users/sign_out.json');
    AuthProvider.logoutMethod('DELETE');
})

.config(function(RestangularProvider) {
  RestangularProvider.setBaseUrl('/api/v1');
  RestangularProvider.setRequestSuffix('.json');
})

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
                controller: 'sessionController'
            }

        }
      })
      // nested routes for our home page

      .state('home.login', {
            url: 'login',
            templateUrl: 'templates/login.html',
            controller: 'sessionController'
      })
        // route to show our basic form (/form)
        .state('home.form', {
            url: '/form',
            templateUrl: 'templates/registration/form.html',
            controller: 'formController'
        })

        // nested states  for our form
        .state('home.form.profile', {
            url: '/profile',
            templateUrl: 'templates/registration/form-profile.html'
        })

        // url will be /form/interests
        .state('home.form.languages', {
            url: '/languages',
            templateUrl: 'templates/registration/form-lang.html'
        })

        // url will be /form/payment
        .state('home.form.availability', {
            url: '/availability',
            templateUrl: 'templates/registration/form-availability.html'
        });


    $stateProvider
      .state('projects', {
        url: '/projects',
        resolve: {
            projects: [ '$http', function($http){
                        return $http.get('api/v1/projects').
                        then(function(response){
                            return response.data
                        }, function(error){
                            return error
                        })
                      }]
     },
        views: {
        '': {
              templateUrl: 'templates/projects/projects.html',
              controller: 'projectsCtrl',
            },

        'navbar': {
            templateUrl: 'templates/header-1.html',
            controller: 'sessionController'
        }

        }
      })


      //request form to join project
      .state('projects.join', {
        url: '/:id/join',
        // controller: 'membershipCtrl',
        // templateUrl: 'templates/projects/participation-request.html'
        views: {
          "": {
            controller: 'membershipCtrl',
            templateUrl: 'templates/projects/participation-request.html'
          }}
      })

  }]);


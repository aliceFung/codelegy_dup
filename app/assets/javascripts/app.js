var app = angular.module('app', ['ngAnimate','ui.router', 'restangular','angularMoment', 'Devise'])


.config(["AuthProvider", function(AuthProvider) {
  AuthProvider.loginPath('/api/v1/users/sign_in.json');
  AuthProvider.loginMethod('POST');
  AuthProvider.logoutPath('/api/v1/users/sign_out.json');
  AuthProvider.logoutMethod('DELETE');
  AuthProvider.registerPath('/api/v1/users.json');
  AuthProvider.registerMethod('POST');
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
      .state('home.signin', {
            url: 'signin',
            templateUrl: 'templates/registration/sign-in.html',
            controller: 'sessionCtrl'
      })
        // route to show our basic form (/form)
        .state('home.form', {
            url: 'form',
            templateUrl: 'templates/registration/form.html',
            controller: 'signUpCtrl'
        })


        // nested states  for our form
        .state('home.form.signup', {
            url: '/signup',
            templateUrl: 'templates/registration/form-sign-up.html',
            controller: 'profileRegistrationCtrl',
            resolve: {
              languageList: [ 'Language', function(Language){
                          return Language.get()
                          .then(function(response){
                              Language.languages = response;
                              return response;
                          }, function(error){
                              return error;
                          });
                        }]
            }
        })

        // url will be /form/interests
        .state('home.form.languages', {
            url: '/languages',
            templateUrl: 'templates/registration/form-lang.html',
            controller: 'profileRegistrationCtrl',
            resolve: {
              languageList: [ 'Language', function(Language){
                          return Language.get()
                          .then(function(response){
                              return response;
                          }, function(error){
                              return error;
                          });
                        }]
            }
        })

        // url will be /form/payment
        .state('home.form.availability', {
            url: '/availability',
            templateUrl: 'templates/registration/form-availability.html',
            controller: 'signUpCtrl'
        });

    $stateProvider
      .state('profiles', {
          url: '/profiles',
          views: {
            '': {templateUrl: 'templates/profiles/layout.html'},

            'navbar': {
                    templateUrl: 'templates/header-1.html',
                    controller: 'sessionCtrl'
            }
          }
      })

      .state('profiles.show', {
        url: '/show/:userid',
        templateUrl: 'templates/profiles/show.html'
      })

      .state('profiles.settings', {
        url: '/settings',
        templateUrl: 'templates/profiles/settings.html', 
        controller: 'accountSettingCtrl'
      });
    $stateProvider
          .state('tour', {
            url: '/tour',
            views:{
              '':{templateUrl: 'templates/registration/tour.html'},
              'navbar': {
                templateUrl: 'templates/header-1.html',
                controller: 'sessionCtrl'
            }

            }
       });
    $stateProvider
      .state('dashboard', {
          url: '/dashboard',
          views: {
            '': {
              templateUrl: 'templates/dashboard/layout.html'
            },
            'navbar': {
              templateUrl: 'templates/header-1.html',
              controller: 'sessionCtrl'
            },
            'profile@dashboard': {
              templateUrl: 'templates/dashboard/profile.html',
              controller: 'dashboardProfileCtrl',
              resolve: {
                profileInfo: [ 'Restangular', 'Auth', function(Restangular, Auth){
                  return Auth.currentUser().then(function(user){
                    return Restangular.all('profiles').customGET(null, {user_id: user.id})
                    .then(function(response){
                      return response;
                    }, function(error){
                      return error;
                    });
                  });
                }],

                languageList: [ 'Language', function(Language){
                  return Language.get()
                  .then(function(response){
                      Language.languages = response;
                      return response;
                  }, function(error){
                      return error;
                  });
                }]
              }
            },
            'projects@dashboard': {
              templateUrl: 'templates/dashboard/projects.html',
              controller: 'userProjectsCtrl'
            },
            'sales@dashboard': {
              templateUrl: 'templates/dashboard/sales.html'
            },
            'suggestions@dashboard': {
              templateUrl: 'templates/dashboard/suggestions.html'
            }
          }
      });

    $stateProvider
      .state('projects', {
        url: '/projects',
        resolve: {
          projects: [ 'Restangular', function(Restangular){
                      return Restangular.all('projects').getList({page: 1})
                      .then(function(response){
                       return response
                      }, function(error){
                          return error
                      })
                    }],
          languages: [ 'Restangular', function(Restangular){
                      return Restangular.all('languages').getList()
                      .then(function(response){
                          return response
                      }, function(error){
                          return error
                      })
                    }],
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
        views: {
        '': {
              templateUrl: 'templates/projects/new.html',
            },
        'navbar': {
            templateUrl: 'templates/header-1.html',
            controller: 'sessionCtrl'
        }

        }
      })

      .state('projects.list', {
        url: '/list',
        views: {
        '': {
              templateUrl: 'templates/projects/index-list.html',
              controller: 'projectsCtrl',
            },

        'navbar': {
            templateUrl: 'templates/header-1.html',
            controller: 'sessionCtrl'
        }

        }
      })

      //request form to join project
      .state('projects.join', {
        url: '/:id/join',
        controller: 'membershipCtrl',
        templateUrl: 'templates/projects/participation-request.html'
      })

      //projects dashboard
      .state('projectsList', {
        url: '/projectsList',
        views: {
          '': {
                controller: 'userProjectsCtrl',
                templateUrl: 'templates/projects_dashboard.html',
              },

          'navbar': {
              templateUrl: 'templates/header-1.html',
              controller: 'sessionCtrl'
          }
        }
      })

      //inbox
      .state('inbox', {
        url: '/inbox',
        views: {
          '': {
                templateUrl: 'templates/mailbox/inbox.html',
                controller: 'emailCtrl',
              },

          'navbar': {
              templateUrl: 'templates/header-1.html',
              controller: 'sessionCtrl'
          }
        }
      })

      //email show state
      .state('email', {
        url: '/inbox/:id',
        views: {
          '': {
                controller: 'emailShowCtrl',
                templateUrl: 'templates/mailbox/email_details.html'
              },

          'navbar': {
              templateUrl: 'templates/header-1.html',
              controller: 'sessionCtrl'
          }
        }
      })

  }]);

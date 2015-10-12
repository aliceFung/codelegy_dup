describe('Controller: membershipCtrl', function(){
  var languages = [{"id":1,"name":"HTML","created_at":"2015-10-07T20:45:00.119Z","updated_at":"2015-10-07T20:45:00.119Z","url":"/logos/html.png","route":"languages","reqParams":null,"restangularized":true,"fromServer":true,"parentResource":null,"restangularCollection":false},
                   {"id":2,"name":"Ruby","created_at":"2015-10-07T20:45:00.129Z","updated_at":"2015-10-07T20:45:00.129Z","url":"/logos/ruby.jpg","route":"languages","reqParams":null,"restangularized":true,"fromServer":true,"parentResource":null,"restangularCollection":false},
                   {"id":3,"name":"Rails","created_at":"2015-10-07T20:45:00.137Z","updated_at":"2015-10-07T20:45:00.137Z","url":"/logos/rails.png","route":"languages","reqParams":null,"restangularized":true,"fromServer":true,"parentResource":null,"restangularCollection":false},
                   {"id":4,"name":"JavaScript","created_at":"2015-10-07T20:45:00.143Z","updated_at":"2015-10-07T20:45:00.143Z","url":"/logos/js.jpg","route":"languages","reqParams":null,"restangularized":true,"fromServer":true,"parentResource":null,"restangularCollection":false},
                   {"id":5,"name":"Node","created_at":"2015-10-07T20:45:00.146Z","updated_at":"2015-10-07T20:45:00.146Z","url":"/logos/node.png","route":"languages","reqParams":null,"restangularized":true,"fromServer":true,"parentResource":null,"restangularCollection":false},
                   {"id":6,"name":"Python","created_at":"2015-10-07T20:45:00.148Z","updated_at":"2015-10-07T20:45:00.148Z","url":"/logos/python.png","route":"languages","reqParams":null,"restangularized":true,"fromServer":true,"parentResource":null,"restangularCollection":false},
                   {"id":7,"name":"Swift","created_at":"2015-10-07T20:45:00.150Z","updated_at":"2015-10-07T20:45:00.150Z","url":"/logos/swift.jpg","route":"languages","reqParams":null,"restangularized":true,"fromServer":true,"parentResource":null,"restangularCollection":false},
                   {"id":8,"name":"Java","created_at":"2015-10-07T20:45:00.152Z","updated_at":"2015-10-07T20:45:00.152Z","url":"/logos/java.png","route":"languages","reqParams":null,"restangularized":true,"fromServer":true,"parentResource":null,"restangularCollection":false},
                   {"id":9,"name":"C","created_at":"2015-10-07T20:45:00.153Z","updated_at":"2015-10-07T20:45:00.153Z","url":"/logos/c.png","route":"languages","reqParams":null,"restangularized":true,"fromServer":true,"parentResource":null,"restangularCollection":false},
                   {"id":10,"name":"PHP","created_at":"2015-10-07T20:45:00.156Z","updated_at":"2015-10-07T20:45:00.156Z","url":"/logos/php.png","route":"languages","reqParams":null,"restangularized":true,"fromServer":true,"parentResource":null,"restangularCollection":false}];

  // var projects = [{"id":118,
  //                  "title":"myProject",
  //                  "availability":"weeknights",
  //                  "description":"really awesome!",
  //                  "difficulty_id":132,
  //                  "created_at":"2015-10-07T23:36:47.641Z",
  //                  "updated_at":"2015-10-07T23:36:47.641Z",
  //                  "difficulty_name":"Beginner",
  //                  "owner":{
  //                     "id":178,
  //                     "username":"foo32",
  //                     "email":"myemail@user32.com",
  //                     "created_at":"2015-10-07T23:36:47.636Z",
  //                     "updated_at":"2015-10-07T23:36:47.636Z",
  //                     "provider":"Github",
  //                     "uid":"1234"
  //                   },
  //                   "languages":[{
  //                             "id" => 1,
  //                           "name" => "HTML",
  //                     "created_at" => "Wed, 07 Oct 2015 22:47:07 UTC +00:00",
  //                     "updated_at" => "Wed, 07 Oct 2015 22:47:07 UTC +00:00",
  //                            "url" => "/logos/html.png"
  //                   }, {
  //                             "id" => 2,
  //                           "name" => "Ruby",
  //                     "created_at" => "Wed, 07 Oct 2015 22:47:07 UTC +00:00",
  //                     "updated_at" => "Wed, 07 Oct 2015 22:47:07 UTC +00:00",
  //                            "url" => "/logos/ruby.png"
  //                   }]},
  //                 {"id":119,
  //                  "title":"myProject2",
  //                  "availability":"tomorrow",
  //                  "description":"really awesome!",
  //                  "difficulty_id":132,
  //                  "created_at":"2015-10-07T23:36:47.641Z",
  //                  "updated_at":"2015-10-07T23:36:47.641Z",
  //                  "difficulty_name":"Beginner",
  //                  "owner":{
  //                     "id":178,
  //                     "username":"foo32",
  //                     "email":"myemail@user32.com",
  //                     "created_at":"2015-10-07T23:36:47.636Z",
  //                     "updated_at":"2015-10-07T23:36:47.636Z",
  //                     "provider":"Github",
  //                     "uid":"1234"
  //                   },
  //                   "languages":[{
  //                             "id" => 1,
  //                           "name" => "HTML",
  //                     "created_at" => "Wed, 07 Oct 2015 22:47:07 UTC +00:00",
  //                     "updated_at" => "Wed, 07 Oct 2015 22:47:07 UTC +00:00",
  //                            "url" => "/logos/html.png"
  //                   }, {
  //                             "id" => 3,
  //                           "name" => "Rails",
  //                     "created_at" => "Wed, 07 Oct 2015 22:47:07 UTC +00:00",
  //                     "updated_at" => "Wed, 07 Oct 2015 22:47:07 UTC +00:00",
  //                            "url" => "/logos/rails.png"
  //                   }]
  //                 },
  //                 {"id":120,
  //                  "title":"myProject3",
  //                  "availability":"weeknights",
  //                  "description":"really awesome!",
  //                  "difficulty_id":132,
  //                  "created_at":"2015-10-07T23:36:47.641Z",
  //                  "updated_at":"2015-10-07T23:36:47.641Z",
  //                  "difficulty_name":"Beginner",
  //                  "owner":{
  //                     "id":178,
  //                     "username":"foo32",
  //                     "email":"myemail@user32.com",
  //                     "created_at":"2015-10-07T23:36:47.636Z",
  //                     "updated_at":"2015-10-07T23:36:47.636Z",
  //                     "provider":"Github",
  //                     "uid":"1234"
  //                   },
  //                   "languages": []}]
  // console.log(languages, projects);

  // beforeEach(module('app'));


})

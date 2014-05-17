

angular.module 'app'
  .controller 'mainController', ($scope)->
    $scope.title = 'Extreme JFA Course'
    $scope.courses = [
      name: 'C# for Super Experts', featured: true, published: new Date('1/1/2014')
    ]
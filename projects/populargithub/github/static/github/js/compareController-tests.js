describe("Formatting Functions", function() {

    it("tests date formating", function() {
        expect(formatGitHubDate(1420693845)).toBe('1/7/2015 9:10')
        expect(formatGitHubDate(1420693745)).toBe('1/7/2015 9:09') //test that 0 is added before minute
    })
})

describe("Angular - SearchController", function() {
    
    var controller, scope;
    
    beforeEach(function() {
        module('githubApp')
        inject(function($controller, $rootScope) {
            scope = $rootScope.$new();
            controller =  $controller('searchCtrl', { $scope: scope });
        })
    })
    it("Tests Default Repositories", function() {
        expect(scope.selectedRepo.length).toBe(2)
    })
    
    it("Tests Removing a Repo", function() {
        scope.remove(scope.selectedRepo[1])
        expect(scope.selectedRepo.length).toBe(1)
        expect(scope.selectedRepo[0].full_name).toBe('sevenwire/forgery')
    })
})
describe 'mvUser', ->
  beforeEach module('app')

  describe 'isAdmin', ->

    it 'should return false if the roles array does not include \'admin\'', (mvUser) ->

      user = new mvUser()
      user.role = ['not admin']

      expect user.isAdmin()
        .to.be.falsey

    it 'should return true if the roles array include \'admin\'', (mvUser) ->

      user = new mvUser()
      user.role = ['admin']

      expect user.isAdmin()
        .to.be.true

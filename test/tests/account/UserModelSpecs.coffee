describe 'UserModel', ->
  beforeEach module('app')

  describe 'isAdmin', ->

    it 'should return false if the roles array does not include \'admin\'', (UserModel) ->

      user = new UserModel()
      user.role = ['not admin']

      expect user.isAdmin()
        .to.be.falsey

    it 'should return true if the roles array include \'admin\'', (UserModel) ->

      user = new UserModel()
      user.role = ['admin']

      expect user.isAdmin()
        .to.be.true

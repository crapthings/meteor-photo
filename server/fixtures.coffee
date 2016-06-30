Meteor.users.remove {}

Files.remove {}

Meteor.startup ->

  unless Meteor.users.findOne { username: 'demo' }
    Accounts.createUser
      username: 'demo'
      password: 'demo'

Meteor.methods

  'updateUserAvatar': (image) ->
    Meteor.users.update @userId,
      $set:
        avatar: image

if Meteor.isServer

  Meteor.publish '', ->
    Meteor.users.find {},
      fields:
        services: false

Template.login.events

  'submit form': (e, t) ->
    do e.preventDefault
    username = ($ t.find '.username').val()
    password = ($ t.find '.password').val()
    Meteor.loginWithPassword username, password

Template.test.onRendered ->

  Files.resumable.assignBrowse ($ @find '#picker')

  Files.resumable.on 'fileAdded', (file) ->

    Files.insert
      _id: file.uniqueIdentifier
      filename: file.fileName
      contentType: file.file.type
      , (err, _id) ->
        Files.resumable.upload()


Template.test.events

  'click .open-camera': (e, t) ->

    navigator.camera.getPicture (image) ->
      Meteor.call 'updateUserAvatar', image
    , ->
      console.log 'no'
    , {
      destinationType: 0
      targetWidth: 120
      targetHeight: 120
    }

  'click .open-album': (e, t) ->

    navigator.camera.getPicture (fileUrl) ->

      window.resolveLocalFileSystemURL fileUrl, (file) ->

        alert Files.resumable.files

    , ->
      console.log 'no'
    , {
      sourceType: 2
    }

Template.files.helpers

  files: ->
    Files.find {}

@Files = new FileCollection 'files',
  resumable: true
  http: [
    {
      method: 'get'
      path: '/:md5'
      lookup: (params, query) -> { md5: params.md5 }
      handler: (req, res, next) ->
        res.setHeader 'Access-Control-Allow-Origin', '*'
        res.setHeader 'Access-Control-Allow-Credentials', true
        do next
    }

    {
       method: 'head',
       path: '/_resumable',
       lookup: (params, query) -> {}
       handler:  (req, res, next) ->
        if req.headers and req.headers.origin
          res.setHeader 'Access-Control-Allow-Origin', req.headers.origin
          res.setHeader 'Access-Control-Allow-Credentials', true
        next()
        return
    }

    {
       method: 'post',
       path: '/_resumable',
       lookup:  (params, query) -> {}
       handler: (req, res, next) ->
        if req.headers and req.headers.origin
           res.setHeader 'Access-Control-Allow-Origin', req.headers.origin
           res.setHeader 'Access-Control-Allow-Credentials', true
        next()
        return
    }

    {
       method: 'options',
       path: '/_resumable',
       lookup:  (params, query) -> {}
       handler: (req, res, next) ->
        if req.headers and req.headers.origin
          res.writeHead 200,
            'Content-Type': 'text/plain'
            'Access-Control-Allow-Origin': req.headers.origin
            'Access-Control-Allow-Credentials': true
            'Access-Control-Allow-Headers': 'x-auth-token, user-agent'
            'Access-Control-Allow-Methods': 'POST, HEAD'
          res.end()
          return
    }
  ]

if Meteor.isServer

  Files.allow

    insert: -> true
    remove: -> true
    read: -> true
    write: -> true

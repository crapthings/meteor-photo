App.accessRule('*', true)
App.accessRule('blob:*')
App.accessRule('data:*', { type: 'navigation' })

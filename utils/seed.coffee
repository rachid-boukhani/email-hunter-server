merge = require('lodash').merge
User = require('../models/user')
Search = require('../models/search')
console.log 'Seeding the Database'
users = [
  {
    email: 'test@gmail.com'
    password: 'tst'
  }
  {
    email: 'test2@gmail.com'
    password: 'tst'
  }
  {
    email: 'test3@gmail.com'
    password: 'tst'
  }
]
searches = [
  {
    name: 'IT companies'
    domains: [
      'stripe.com'
      'upwork.com'
      'asana.com'
    ]
  }
  {
    name: 'Telecommunications Companies'
    domains: [
      'verizon.cm'
      'att.com'
      'vodafone.com'
    ]
  }
  {
    name: 'Entertainment service'
    domains: [
      'netflix.com'
      'hulu.com'
    ]
  }
]

cleanDB = ->
  console.log '... cleaning the DB'
  cleanPromises = [
    User
    Search
  ].map((model) ->
    model.remove().exec()
    return
  )
  Promise.all cleanPromises

createDoc = (Model, doc) ->
  new Promise((resolve, reject) ->
    new Model(doc).save (err, saved) ->
      if err then reject(err) else resolve(saved)
    return
)

createUsers = (data) ->
  promises = users.map((user) ->
    createDoc User, user
  )
  Promise.all(promises).then (users) ->
    merge { users: users }, data or {}

createSearches = (data) ->
  newSearches = searches.map((search, i) ->
    search.owner = data.users[i]._id
    createDoc Search, search
  )
  Promise.all(newSearches).then ->
    'Seeded DB with3 Users, 3 Searches'

cleanDB().then(createUsers).then(createSearches).then(console.log.bind(console)).catch console.log.bind(console)

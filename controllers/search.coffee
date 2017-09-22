passport = require('passport')
searchModel = require('../models/search')

exports.getSearches = (req, res) ->
  searchModel.find(owner: req.user._id).then (searches) ->
    req.session.messages = req.session.messages or []
    message = req.session.messages.pop()
    res.render 'search/list',
      searches: searches
      user: req.user
      message: message

exports.getAddSearch = (req, res) ->
  res.render 'search/add', user: req.user

exports.postSearch = (req, res) ->
  if !req.body.name.length
    return res.render('search/add',
      user: req.user
      message: error: 'Search name is required')
  domains = [
    'domain1'
    'domain2'
    'domain3'
  ].map((item) ->
    req.body[item]
  ).filter((item) ->
    item
  )
  if !domains.length
    return res.render('search/add',
      user: req.user
      message: error: 'At least one domain should be entered')
  newSearch = 
    name: req.body.name
    owner: req.user
    domains: domains
  searchModel.create(newSearch).then ((search) ->
    req.session.messages = req.session.messages or []
    req.session.messages.push success: 'Search has been saved successfully'
    res.redirect '/search'
    return
  ), (error) ->
    if error.name == 'MongoError' and error.code == 11000
      res.render 'search/add',
        user: req.user
        message: error: 'Search name must be unique'
    else
      next error

requestp = require('request-promise')
config = require('../config')
searchModel = require('../models/search')

exports.params = (req, res, next, id) ->
  searchModel.findById(id).then ((search) ->
    if !search
      next new Error('undefined search')
    else
      req.search = search
      next()
  ), next

exports.run = (req, res, next) ->
  requests = req.search.domains.map((domain) ->
    requestp config.API.path.replace('[:domain]', domain), true
  )
  Promise.all(requests).then((values) ->
    results = values.map (item) ->
      item = JSON.parse(item)
      return {
        domain: item.meta.params.domain
        total: item.data.total
        personal: item.data.personal_emails
        generic: item.data.generic_emails
      }
    res.render 'run/result',
      results: results
      search: req.search
      user: req.user
  ).catch next

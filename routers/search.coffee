Router = require('express').Router
searchController = require('../controllers/search')

router = Router()

router.route('/').get searchController.getSearches
router.route('/add').get(searchController.getAddSearch).post searchController.postSearch

module.exports = router

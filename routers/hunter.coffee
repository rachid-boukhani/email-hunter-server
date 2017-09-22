Router = require('express').Router
hunterController = require('../controllers/hunterEmail')

router = Router()
router.param 'id', hunterController.params
router.route('/:id').get hunterController.run

module.exports = router

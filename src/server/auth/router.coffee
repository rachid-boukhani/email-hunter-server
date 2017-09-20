import {Router} from 'express'
import controller from './controller'

router = Router()

router.post '/signin', controller.signin

export default router

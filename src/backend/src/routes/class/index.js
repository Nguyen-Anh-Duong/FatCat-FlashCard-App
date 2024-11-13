'use strict'

const express = require('express')
const expressAsyncHandler = require('express-async-handler')
const router = express.Router()
const ClassController = require('../../controllers/class.controller')

router.post('/', expressAsyncHandler(ClassController.createClass))
router.get('/', expressAsyncHandler(ClassController.getAllClasses))
router.get('/own_classes', expressAsyncHandler(ClassController.getClassByUserId))
router.post('/:code_invite', expressAsyncHandler(ClassController.joinClass))
router.delete('/:class_id', expressAsyncHandler(ClassController.leaveClass))
router.patch('/:class_id', expressAsyncHandler(ClassController.updateClass))
router.get('/:class_id/members', expressAsyncHandler(ClassController.getMembersOfClass))


module.exports = router
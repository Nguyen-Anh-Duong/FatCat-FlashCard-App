'use strict'

const { SuccessResponse } = require("../core/success.response")
const ClassService = require("../services/class.service")

class ClassController {
    async createClass(req, res) {
        new SuccessResponse({
            message: "Create class successfully",
            metadata: await ClassService.createClass({
                ...req.body,
                ...req.user
            })
        }).send(res)
    }
    async getAllClasses(req, res) {
        new SuccessResponse({
            message: "Get all classes successfully",
            metadata: await ClassService.getClassesForHost(req.user.id)
        }).send(res)
    }
    async getClassByUserId(req, res) {
        new SuccessResponse({
            message: "Get class by user id successfully",
            metadata: await ClassService.getClassesByUserId({userId: req.user.userId, sortBy: req.query.sortBy})
        }).send(res)
    }
    async joinClass(req, res) {
        new SuccessResponse({
            message: "Join class successfully",
            metadata: await ClassService.joinClass(req.user.id, req.params.code_invite)
        }).send(res)
    }
    async leaveClass(req, res) {
        new SuccessResponse({
            message: "Leave class successfully",
            metadata: await ClassService.leaveClass({userId: req.user.id, classId: req.params.class_id})
        }).send(res)
    }
    async deleteClass(req, res) {
        new SuccessResponse({
            message: "Delete class successfully",
            metadata: await ClassService.deleteClass({
                classId: req.params.class_id,
                userId: req.user.id
            })
        }).send(res)
    }
    async updateClass(req, res) {
        new SuccessResponse({
            message: "Update class successfully",
            metadata: await ClassService.updateClass(req.body)
        }).send(res)
    }
    async getMembersOfClass(req, res) {
        new SuccessResponse({
            message: "Get members of class successfully",
            metadata: await ClassService.getMembers({classId: req.params.class_id})
        }).send(res)
    }
}

module.exports = new ClassController()

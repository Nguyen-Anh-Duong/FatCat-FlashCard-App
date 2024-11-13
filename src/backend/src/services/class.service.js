'use strict'

const { pick } = require("lodash")
const { NotFoundError } = require("../core/error.response")
const { ClassModel, ClassMember } = require("../models")
const { createUniqueInviteCode } = require("../utils")
 
class ClassService {
    static createClass = async({name, description, userId }) => {
        console.log("name, description, userId::", name, description, userId)
        if(!name || !description || !userId) {
            throw new NotFoundError("Name, description or userId is required")
        }
        
        const inviteCode = await createUniqueInviteCode();
        if(!inviteCode)
            throw new NotFoundError("create invite code failed")

         const newClass = await ClassModel.create({
            name: name,
            description: description,
            code_invite: inviteCode,
            host_user_id: userId,
            member_count: 1,
        })
        if(!newClass)
            throw new NotFoundError("Create class failed")

        const newMember = await ClassMember.create({
            user_id: userId,
            class_id: newClass.id,
            role: "host",
        })
        if(!newMember)
            throw new NotFoundError("Create member failed")
   
        return {
            class: pick(newClass, ["id", "name", "description", "code_invite"]),
            member: pick(newMember, ["id", "user_id", "class_id", "role"]),
        }
    }
    static getClassesForHost = async({userId}) => {
        const classes = await ClassModel.findAll({where: {host_user_id: userId}})
        return classes
    }
    static joinClass = async({userId, codeInvite}) => {
        const foundClass = await ClassModel.findOne({where: {code_invite: codeInvite}})
        if(!foundClass)
            return new NotFoundError("Class not found")

        const newMember = await MemberModel.create({userId, classId: foundClass.id})
        if(!newMember)
            return new NotFoundError("Join class failed")

        return "Join class successfully"
    }

    static getMembers = async({classId}) => {
        const members = await ClassMember.findAll({where: {group_id: classId}})
        return members
    }
    static getClassesByUserId = async({userId, sortBy = "member_count"}) => {
        const order = [];
        
        if (sortBy === 'member_count') {
            order.push([{ model: ClassModel }, 'member_count', 'DESC']);
        } else if (sortBy === 'created_at') {
            order.push([{ model: ClassModel }, 'created_at', 'DESC']);
        } else if (sortBy === 'updated_at') {
            order.push([{ model: ClassModel }, 'updated_at', 'DESC']);
        }
        console.log(`userId: ${userId}`)
        console.log(`order: ${order}`)
        const classes = await ClassMember.findAll({
            where: { user_id: userId },
            include: [{
                model: ClassModel,
                as: "Class",
                attributes: ['id', 'name', 'description', 'host_user_id', 'member_count', 'code_invite']
            }],
            order: order.length ? order : undefined
        });

        return classes
    }
    static deleteClass = async({classId}) => {
        const deletedClass = await ClassModel.destroy({where: {id: classId}})
        return deletedClass
    }
    static updateClass = async({classId, name, description}) => {
        const updatedClass = await ClassModel.update({name, description}, {where: {id: classId}})
        return updatedClass
    }
    static deleteMember = async({userId, classId}) => {
        const deletedMember = await ClassMember.destroy({where: {user_id: userId, group_id: classId}})
        return deletedMember
    }
    static updateMember = async({userId, classId, role}) => {
        const updatedMember = await ClassMember.update({role}, {where: {user_id: userId, group_id: classId}})
        return updatedMember
    }
}

module.exports = ClassService
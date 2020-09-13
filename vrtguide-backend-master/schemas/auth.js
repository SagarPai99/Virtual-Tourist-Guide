const Joi = require('@hapi/joi');

exports.findOrRegisterUser = Joi.object({
    body: Joi.object({
        gid: Joi.string().required(),
        name: Joi.string().required(),
        email: Joi.string().email().required(),
        photoUrl: Joi.string().required()
    }).required()
});

exports.updateUser = Joi.object({
    body: Joi.object({
        gid: Joi.string().required(),
        name: Joi.string().required(),
        email: Joi.string().email().required(),
        photoUrl: Joi.string().required(),
        nationality: Joi.string().required()
    }).required()
});
const Joi = require('@hapi/joi');

exports.createBlogPost = Joi.object({
    body: Joi.object({
        titleText: Joi.string().required(),
        titleImg: Joi.string().required(),
        shortDesc: Joi.string().required(),
        longDesc: Joi.string().required()
    }).required()
});

exports.updateBlogPost = Joi.object({
    body: Joi.object({
        bid: Joi.number().integer().required(),
        titleText: Joi.string().required(),
        titleImg: Joi.string().required(),
        shortDesc: Joi.string().required(),
        longDesc: Joi.string().required()
    }).required()
});

exports.createComment = Joi.object({
    body: Joi.object({
        bid: Joi.number().integer().required(),
        comment: Joi.string().required()
    }).required()
});

exports.getComments = Joi.object({
    body: Joi.object({
        bid: Joi.number().integer().required()
    }).required()
});

exports.upvoteOrDownvoteBlogPost = Joi.object({
    body: Joi.object({
        bid: Joi.number().integer().required(),
        upOrDown: Joi.number().integer().valid(0,1).required()
    }).required()
});

exports.upvoteOrDownvoteComment = Joi.object({
    body: Joi.object({
        cid: Joi.number().integer().required(),
        upOrDown: Joi.number().integer().valid(0,1).required()
    }).required()
});
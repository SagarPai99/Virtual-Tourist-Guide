const Joi = require('@hapi/joi');

exports.getLandmarkInfoById = Joi.object({
    body: Joi.object({
        lid: Joi.number().integer().required()
    }).required()
});

exports.createOrUpdateReview = Joi.object({
    body: Joi.object({
        lid: Joi.number().integer().required(),
        rating: Joi.number().required(),
        comments: Joi.string().required()
    }).required()
});

exports.upvoteOrDownvote = Joi.object({
    body: Joi.object({
        lid: Joi.number().integer().required(),
        upOrDown: Joi.number().integer().valid(0,1).required()
    }).required()
});

exports.visitLandmark = Joi.object({
    body: Joi.object({
        lid: Joi.number().integer().required()
    }).required()
});

exports.nearbyOrSimilarLandmark = Joi.object({
    body: Joi.object({
        lid: Joi.number().integer().required()
    }).required()
});
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '../.env') });

const express = require('express');

var router = express.Router();

const validator = require('../utils/validator');

const auth = require('./auth');
const authSchema = require('../schemas/auth');

const blogs = require('./blogs');
const blogsSchema = require('../schemas/blogs');

const landmarks = require('./landmarks');
const landmarksSchema = require('../schemas/landmarks');

const stats = require('./stats');

function loggedIn(access){
    return (req, res, next) => {
        if( req.session.loggedIn && req.session.type >= access ) return next();
        else return res.sendError(null, 'Not Logged In');
    };
}

// Authentication
router.post(
    '/auth/findOrRegisterUser',
    validator(authSchema.findOrRegisterUser),
    auth.findOrRegisterUser 
);
router.post(
    '/auth/updateUserInfo',
    loggedIn(0),
    validator(authSchema.updateUser),
    auth.updateUserInfo
);
router.get(
    '/auth/logout',
    loggedIn(0),
    auth.logout
);

// Blogs
router.post(
    '/blogs/createBlogPost',
    loggedIn(0),
    validator(blogsSchema.createBlogPost),
    blogs.createBlogPost
);
router.post(
    '/blogs/updateBlogPost',
    loggedIn(0),
    validator(blogsSchema.updateBlogPost),
    blogs.updateBlogPost
);
router.get(
    '/blogs/personalBlogs',
    loggedIn(0),
    blogs.personalBlogs
);
router.get(
    '/blogs/allBlogs',
    blogs.allBlogs
);
router.post(
    '/blogs/createComment',
    loggedIn(0),
    validator(blogsSchema.createComment),
    blogs.createComment
);
router.post(
    '/blogs/getComments',
    validator(blogsSchema.getComments),
    blogs.getComments
);
router.post(
    '/blogs/upvoteOrDownvoteBlogPost',
    loggedIn(0),
    validator(blogsSchema.upvoteOrDownvoteBlogPost),
    blogs.upvoteOrDownvoteBlogPost
);
router.post(
    '/blogs/upvoteOrDownvoteComment',
    loggedIn(0),
    validator(blogsSchema.upvoteOrDownvoteComment),
    blogs.upvoteOrDownvoteComment
);

// Landmarks
router.get(
    '/landmarks/getLandmarks',
    landmarks.getLandmarks
);
router.post(
    '/landmarks/getLandmarkInfoById',
    validator(landmarksSchema.getLandmarkInfoById),
    landmarks.getSpecificLandmarkInfo
);
router.post(
    '/landmarks/getLandmarkReviews',
    validator(landmarksSchema.getLandmarkInfoById),
    landmarks.getLandmarkReviews
);
router.post(
    '/landmarks/getLandmarkPictures',
    validator(landmarksSchema.getLandmarkInfoById),
    landmarks.getLandmarkPictures
);
router.post(
    '/landmarks/createOrUpdateReview',
    loggedIn(0),
    validator(landmarksSchema.createOrUpdateReview),
    landmarks.createOrUpdateReview
);
router.post(
    '/landmarks/visitLandmark',
    loggedIn(0),
    validator(landmarksSchema.visitLandmark),
    landmarks.visitLandmark
);
router.post(
    '/landmarks/nearbyLandmark',
    validator(landmarksSchema.nearbyOrSimilarLandmark),
    landmarks.nearbyLandmark
);
router.post(
    '/landmarks/similarLandmark',
    validator(landmarksSchema.nearbyOrSimilarLandmark),
    landmarks.similarLandmark
);

// Stats
router.post(
    '/stats/majorStats',
    loggedIn(1),
    stats.majorStats
);

module.exports = router;
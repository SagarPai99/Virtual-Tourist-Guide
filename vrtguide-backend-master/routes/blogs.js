const db = require('../config/db');
const to = require('../utils/to');

exports.createBlogPost = async(req, res) => {
    try{
        let err, result;
        [err,result] = await to(db.query("INSERT INTO blog_posts(uid,titleText,titleImg,shortDesc,longDesc) VALUES(?,?,?,?,?)",[ req.session.uid, req.body.titleText, req.body.titleImg, req.body.shortDesc, req.body.longDesc ]));
        if(err) return res.sendError(err);
        else return res.sendSuccess(null);
    }catch(err){
        return res.sendError(err);
    }
};

exports.updateBlogPost = async(req, res) => {
    try{
        let err, result;
        [err,result] = await to(db.query("UPDATE blog_posts SET titleText = ?, titleImg = ?, shortDesc = ?, longDesc = ? WHERE bid = ? AND uid = ?",[ req.body.titleText , req.body.titleImg , req.body.shortDesc , req.body.longDesc , req.body.bid , req.session.uid ]));
        if(err) return res.sendError(err);
        else if( result.changedRows <= 0 ) return res.sendError(null);
        else return res.sendSuccess(null);
    }catch(err){
        return res.sendError(err);
    }
};

exports.personalBlogs = async(req, res) => {
    try{
        let err, result;
        [err,result] = await to(db.query("SELECT bp.bid AS bid , bp.uid AS uid , ( SELECT name FROM users WHERE uid = bp.uid ) AS name, ( SELECT email FROM users WHERE uid = bp.uid ) AS email, ( SELECT photoUrl FROM users WHERE uid = bp.uid ) AS photoUrl, bp.titleText AS titleText, bp.titleImg AS titleImg, bp.shortDesc AS shortDesc, bp.longDesc AS longDesc , ( SELECT IFNULL( count(uid) , 0 ) FROM blog_posts_upordown WHERE bid = bp.bid AND upOrDown = 1 ) AS upvotes, ( SELECT IFNULL( count(uid) , 0 ) FROM blog_posts_upordown WHERE bid = bp.bid AND upOrDown = 0 ) AS downvotes FROM blog_posts AS bp WHERE bp.uid = ? ORDER BY upvotes DESC",[ req.session.uid ]));
        if(err) return res.sendError(err);
        else return res.sendSuccess(result);
    }catch(err){
        return res.sendError(err);
    }
};

exports.allBlogs = async(req, res) => {
    try{
        let err, result;
        [err,result] = await to(db.query("SELECT bp.bid AS bid , bp.uid AS uid , ( SELECT name FROM users WHERE uid = bp.uid ) AS name, ( SELECT email FROM users WHERE uid = bp.uid ) AS email, ( SELECT photoUrl FROM users WHERE uid = bp.uid ) AS photoUrl, bp.titleText AS titleText, bp.titleImg AS titleImg, bp.shortDesc AS shortDesc, bp.longDesc AS longDesc , ( SELECT IFNULL( count(uid) , 0 ) FROM blog_posts_upordown WHERE bid = bp.bid AND upOrDown = 1 ) AS upvotes, ( SELECT IFNULL( count(uid) , 0 ) FROM blog_posts_upordown WHERE bid = bp.bid AND upOrDown = 0 ) AS downvotes FROM blog_posts AS bp ORDER BY upvotes DESC"));
        if(err) return res.sendError(err);
        else return res.sendSuccess(result);
    }catch(err){
        return res.sendError(err);
    }
};

exports.createComment = async(req, res) => {
    try{
        let err, result;
        [err,result] = await to(db.query("INSERT INTO blog_comments(bid,uid,comment) VALUES(?,?,?)",[ req.body.bid , req.session.uid , req.body.comment ]));
        if(err) return res.sendError(err);
        else return res.sendSuccess(null);
    }catch(err){
        return res.sendError(err);
    }
};

exports.getComments = async(req, res) => {
    try{
        let err, result;
        [err,result] = await to(db.query("SELECT bc.cid AS cid , bc.bid AS bid , bc.uid AS uid , ( SELECT name FROM users WHERE uid = bc.uid ) AS name, ( SELECT email FROM users WHERE uid = bc.uid ) AS email, ( SELECT photoUrl FROM users WHERE uid = bc.uid ) AS photoUrl , bc.comment AS comment , ( SELECT IFNULL( count(uid) , 0 ) FROM blog_comments_upordown WHERE cid = bc.cid AND upOrDown = 1 ) AS upvotes, ( SELECT IFNULL( count(uid) , 0 ) FROM blog_comments_upordown WHERE cid = bc.cid AND upOrDown = 0 ) AS downvotes , bc.createdAt AS createdAt FROM blog_comments AS bc WHERE bc.bid = ? ORDER BY upvotes DESC , downvotes ASC , bc.createdAt DESC",[ req.body.bid ]));
        if(err) return res.sendError(err);
        else return res.sendSuccess(result);
    }catch(err){
        return res.sendError(err);
    }
};

exports.upvoteOrDownvoteBlogPost = async(req, res) => {
    try{
        let err, result;
        [err,result] = await to(db.query("UPDATE blog_posts_upordown SET upOrDown = ? WHERE bid = ? AND uid = ?",[ req.body.upOrDown , req.body.bid , req.session.uid ]));
        if(err) return res.sendError(err);
        else if( result.changedRows <= 0 ){
            [err,result] = await to(db.query("INSERT INTO blog_posts_upordown VALUES(?,?,?)",[ req.body.bid , req.session.uid , req.body.upOrDown ]));
            if(err) return res.sendError(err);
            else return res.sendSuccess(null);
        }else return res.sendSuccess(null);
    }catch(err){
        return res.sendError(err);
    }
};

exports.upvoteOrDownvoteComment = async(req, res) => {
    try{
        let err, result;
        [err,result] = await to(db.query("UPDATE blog_comments_upordown SET upOrDown = ? WHERE cid = ? AND uid = ?",[ req.body.upOrDown , req.body.cid , req.session.uid ]));
        if(err) return res.sendError(err);
        else if( result.changedRows <= 0 ){
            [err,result] = await to(db.query("INSERT INTO blog_comments_upordown VALUES(?,?,?)",[ req.body.cid , req.session.uid , req.body.upOrDown ]));
            if(err) return res.sendError(err);
            else return res.sendSuccess(null);
        }else return res.sendSuccess(null);
    }catch(err){
        return res.sendError(err);
    }
};
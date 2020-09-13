const db = require('../config/db');
const to = require('../utils/to');

exports.findOrRegisterUser = async (req, res) => {
    try{
        if( req.session.loggedIn ) return res.sendSuccess(req.session);
        let err, result;
        [err,result] = await to(db.query("SELECT * FROM users WHERE gid = ?",[ req.body.gid ]));
        if(err) return res.sendError(err);
        else if( result.length <= 0 ){
            [err,result] = await to(db.query("INSERT INTO users(gid,name,email,photoUrl) VALUES(?,?,?,?)",[ req.body.gid, req.body.name, req.body.email, req.body.photoUrl ]));
            if(err && err.code === 'ER_DUP_ENTRY') return res.sendError(err, 'User already exists.');
            else if(err) return res.sendError(err);
            else{
                req.session.loggedIn = true;
                req.session.uid = result.insertId;
                req.session.gid = req.body.gid;
                req.session.name = req.body.name;
                req.session.email = req.body.email;
                req.session.photoUrl = req.body.photoUrl;
                req.session.nationality = null;
                req.session.type = 0;
                req.session.save( err => {
                    if(err) return res.sendError(err);
                    else return res.sendSuccess({ 
                        "uid" : result.insertId,
                        "gid" : req.body.gid,
                        "name" : req.body.name,
                        "email" : req.body.email,
                        "photoUrl" : req.body.photoUrl,
                        "nationality" : null,
                        "type" : 0
                    });
                });
            }
        }
        else{
            req.session.loggedIn = true;
            req.session.uid = result[0].uid;
            req.session.gid = result[0].gid;
            req.session.name = result[0].name;
            req.session.email = result[0].email;
            req.session.photoUrl = result[0].photoUrl;
            req.session.nationality = result[0].nationality;
            req.session.type = result[0].type;
            req.session.save( err => {
                if(err) return res.sendError(err);
                else return res.sendSuccess({
                    "uid" : result[0].uid,
                    "gid" : result[0].gid,
                    "name" : result[0].name,
                    "email" : result[0].email,
                    "photoUrl" : result[0].photoUrl,
                    "nationality" : result[0].nationality,
                    "type" : result[0].type
                });
            });
        }
    }catch(err){
        return res.sendError(err);
    }
};

exports.updateUserInfo = async(req, res) => {
    try{
        let err, result;
        [err,result] = await to(db.query("UPDATE users SET gid = ?, name = ?, email = ?, photoUrl = ?, nationality = ? WHERE uid = ?",[ req.body.gid, req.body.name, req.body.email, req.body.photoUrl, req.body.nationality, req.session.uid ]));
        if(err) return res.sendError(err);
        else if( result.changedRows <= 0 ) return res.sendError(null);
        else{
            req.session.gid = req.body.gid;
            req.session.name = req.body.name;
            req.session.email = req.body.email;
            req.session.photoUrl = req.body.photoUrl;
            req.session.nationality = req.body.nationality;
            req.session.save( err => {
                if(err) return res.sendError(err);
                else return res.sendSuccess(req.session);
            });
        }
    }catch(err){
        return res.sendError(err);
    }
};

exports.logout = async(req, res) => {
    try{
        req.session.destroy( err => {
            if(err) return res.sendError(err);
            else return res.sendSuccess(null);
        });
    }catch(err){
        return res.sendError(err);
    }
};
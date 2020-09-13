const db = require('../config/db');
const to = require('../utils/to');

exports.getLandmarks = async(req, res) => {
    try{
        let err, result;
        var data = {};
        [err,result] = await to(db.query("SELECT lm.lid AS lid, lm.name AS name, lm.lat AS lat, lm.lng AS lng, lm.l_desc AS l_desc, lm.s_desc AS s_desc, lm.start_at AS start_at, lm.end_at AS end_at, lm.contact_phone AS contact_phone, lm.contact_email AS contact_email, lm.lookups AS lookups, lm.landscapeTitlePhotoUrl AS landscapeTitlePhotoUrl, lm.portraitTitlePhotoUrl AS portraitTitlePhotoUrl, ( SELECT IFNULL(AVG(lr.rating),0.0) FROM landmark_reviews AS lr WHERE lr.lid = lm.lid ) AS rating FROM landmarks AS lm"));
        if(err) return res.sendError(err);
        data['landmarks'] = result;
        [err,result] = await to(db.query("SELECT * FROM landmark_tags"));
        if(err) return res.sendError(err);
        data['tags'] = {};
        for( var i = 0 ; i < result.length ; i++ ){
            if( data['tags'].hasOwnProperty( result[i]['lid'] ) ) data['tags'][result[i]['lid']].push( result[i]['tag'] );
            else data['tags'][result[i]['lid']] = [ result[i]['tag'] ];
        }
        return res.sendSuccess(data);
    }catch(err){
        return res.sendError(err);
    }
};

exports.getSpecificLandmarkInfo = async(req, res) => {
    try{
        let err, result;
        var data = {};
        [err,result] = await to(db.query("SELECT lm.lid AS lid, lm.name AS name, lm.lat AS lat, lm.lng AS lng, lm.l_desc AS l_desc, lm.s_desc AS s_desc, lm.start_at AS start_at, lm.end_at AS end_at, lm.contact_phone AS contact_phone, lm.contact_email AS contact_email, lm.lookups AS lookups, lm.landscapeTitlePhotoUrl AS landscapeTitlePhotoUrl, lm.portraitTitlePhotoUrl AS portraitTitlePhotoUrl, ( SELECT IFNULL(AVG(lr.rating),0.0) FROM landmark_reviews AS lr WHERE lr.lid = lm.lid ) AS rating FROM landmarks AS lm WHERE lm.lid = ?",[ req.body.lid ]));
        if(err) return res.sendError(err);
        if( result.length <= 0 ) return res.sendError(null);
        data['landmark_info'] = result[0];
        [err,result] = await to(db.query("SELECT tag FROM landmark_tags WHERE lid = ?",[ req.body.lid ]));
        if(err) return res.sendError(err);
        data['tags'] = [];
        for( var i = 0 ; i < result.length ; i++ ){
            data['tags'].push( result[i]['tag'] );
        }
        return res.sendSuccess(data);
    }catch(err){
        return res.sendError(err);
    }
};

exports.getLandmarkReviews = async(req, res) => {
    try{
        let err, result;
        [err,result] = await to(db.query("SELECT lr.uid AS uid, ( SELECT name FROM users WHERE uid = lr.uid ) AS name, ( SELECT email FROM users WHERE uid = lr.uid ) AS email, ( SELECT photoUrl FROM users WHERE uid = lr.uid ) AS photoUrl, lr.rating AS rating, lr.comments AS comments FROM landmark_reviews AS lr WHERE lr.lid = ?",[ req.body.lid ]));
        if(err) return res.sendError(err);
        else if( result.length <= 0 ) return res.sendError(null);
        else return res.sendSuccess(result);
    }catch(err){
        return res.sendError(err);
    }
};

exports.getLandmarkPictures = async(req, res) => {
    try{
        let err, result;
        [err,result] = await to(db.query("SELECT photoUrl FROM landmark_pictures WHERE lid = ?",[ req.body.lid ]));
        if(err) return res.sendError(err);
        else return res.sendSuccess(result);
    }catch(err){
        return res.sendError(err);
    }
};

exports.createOrUpdateReview = async(req, res) => {
    try{
        let err, result;
        [err,result] = await to(db.query("UPDATE landmark_reviews SET rating = ?, comments = ? WHERE lid = ? AND uid = ?",[ req.body.rating, req.body.comments, req.body.lid, req.session.uid ]));
        if(err) return res.sendError(err);
        else if( result.changedRows <= 0 ){
            [err,result] = await to(db.query("INSERT INTO landmark_reviews(lid,uid,rating,comments) VALUES(?,?,?,?)",[ req.body.lid, req.session.uid, req.body.rating, req.body.comments ]));
            if(err) return res.sendError(err);
            else return res.sendSuccess(null);
        }else return res.sendSuccess(null);
    }catch(err){
        return res.sendError(err);
    }
};

exports.visitLandmark = async(req, res) => {
    try{
        let err, result;
        [err,result] = await to(db.query("INSERT INTO landmark_visited_config(lid,uid) VALUES(?,?)",[ req.body.lid, req.session.uid ]));
        if(err) return res.sendError(err);
        [err,result] = await to(db.query("UPDATE landmarks SET lookups = lookups + 1 WHERE lid = ?",[ parseInt(req.body.lid) ]));
        if(err) return res.sendError(err);
        else return res.sendSuccess(null);
    }catch(err){
        return res.sendError(err);
    }
};

exports.nearbyLandmark = async(req, res) => {
    try{
        let err, result, lat, lng;
        var landmark_tags = {};
        [err,result] = await to(db.query("SELECT * FROM landmark_tags"));
        if(err) return res.sendError(err);
        for( var i = 0 ; i < result.length ; i++ ){
            if( !landmark_tags.hasOwnProperty(result[i]["lid"]) ) landmark_tags[result[i]["lid"]] = [];
            landmark_tags[result[i]["lid"]].push(result[i]["tag"]);
        }
        [err,result] = await to(db.query("SELECT lat,lng FROM landmarks WHERE lid = ?",[ req.body.lid ]));
        if(err) return res.sendError(err);
        lat = result[0]['lat'];
        lng = result[0]['lng'];
        [err,result] = await to(db.query("SELECT lm.lid AS lid, lm.name AS name, lm.lat AS lat, lm.lng AS lng, lm.l_desc AS l_desc, lm.s_desc AS s_desc, lm.start_at AS start_at, lm.end_at AS end_at, lm.contact_phone AS contact_phone, lm.contact_email AS contact_email, lm.lookups AS lookups, lm.landscapeTitlePhotoUrl AS landscapeTitlePhotoUrl, lm.portraitTitlePhotoUrl AS portraitTitlePhotoUrl, ( SELECT IFNULL(AVG(lr.rating),0.0) FROM landmark_reviews AS lr WHERE lr.lid = lm.lid ) AS rating , 111.045 * DEGREES(ACOS(COS(RADIANS(?)) * COS(RADIANS(lm.lat)) * COS(RADIANS(lm.lng) - RADIANS(?)) + SIN(RADIANS(?)) * SIN(RADIANS(lm.lat)))) AS distance_in_km FROM landmarks AS lm WHERE lm.lid <> ? ORDER BY distance_in_km ASC",[ lat , lng , lat , parseInt(req.body.lid) ]));
        if(err) return res.sendError(err);
        if( result.length <= 0 ) return res.sendSuccess(result);
        result[0]['distance_in_km'] = parseFloat( result[0]['distance_in_km'] );
	result[0]['tags'] = landmark_tags[result[0]['lid']];
        var mn = result[0]['distance_in_km'] , mx = result[0]['distance_in_km'];
        for( var i = 1 ; i < result.length ; i++ ){
            result[i]['distance_in_km'] = parseFloat( result[i]['distance_in_km'] );
            result[i]['tags'] = landmark_tags[result[i]['lid']];
            mn = Math.min( mn , result[i]['distance_in_km'] );
            mx = Math.max( mx , result[i]['distance_in_km'] );
        }
        if( Math.abs(mx-mn) > Number.EPSILON ) for( var i = 0 ; i < result.length ; i++ ) result[i]['distance_in_km'] = ( result[i]['distance_in_km']-mn ) / ( mx-mn );
        return res.sendSuccess(result);
    }catch(err){
        return res.sendError(err);
    }
};

exports.similarLandmark = async(req, res) => {
    try{
        let err, result;
        var tags = {};
        var landmark_similarities = [];
        var landmark_data = {};
        [err,result] = await to(db.query("SELECT lm.lid AS lid, lm.name AS name, lm.lat AS lat, lm.lng AS lng, lm.l_desc AS l_desc, lm.s_desc AS s_desc, lm.start_at AS start_at, lm.end_at AS end_at, lm.contact_phone AS contact_phone, lm.contact_email AS contact_email, lm.lookups AS lookups, lm.landscapeTitlePhotoUrl AS landscapeTitlePhotoUrl, lm.portraitTitlePhotoUrl AS portraitTitlePhotoUrl, ( SELECT IFNULL(AVG(lr.rating),0.0) FROM landmark_reviews AS lr WHERE lr.lid = lm.lid ) AS rating FROM landmarks AS lm"));
        if(err) return res.sendError(err);
        for( var i = 0 ; i < result.length ; i++ ) landmark_data[ result[i]["lid"] ] = result[i];
        [err,result] = await to(db.query("SELECT * FROM landmark_tags"));
        if(err) return res.sendError(err);
        for( var i = 0 ; i < result.length ; i++ ){
            if( !tags.hasOwnProperty(result[i]['lid']) ) tags[result[i]['lid']] = new Set();
            tags[result[i]['lid']].add( result[i]['tag'] );
        }
        if( !tags.hasOwnProperty(req.body.lid) ) return res.sendError(null, 'Invalid Landmark ID');
        for( var x in tags ){
            if( x != req.body.lid ){
                var all_tags = [...tags[x]];
                var similar_tags = all_tags.filter( value => tags[req.body.lid].has(value) );
                if( similar_tags.length > 0 ){
                    landmark_similarities.push({
                        'lid' : x,
                        'similar_tags' : similar_tags,
                        'all_tags' : all_tags,
                        'similarities' : parseFloat( similar_tags.length ),
                        'landmark_data' : landmark_data[x]
                    });
                }
            }
        }
        if( landmark_similarities.length <= 0 ) return res.sendSuccess(landmark_similarities);
        landmark_similarities.sort( (a,b) => {
            return a['similarities'] > b['similarities'];
        });
        var mn = landmark_similarities[0]['similarities'] , mx = landmark_similarities[0]['similarities'];
        for( var i = 1 ; i < landmark_similarities.length ; i++ ){
            mn = Math.min( mn , landmark_similarities[i]['similarities'] );
            mx = Math.max( mx , landmark_similarities[i]['similarities'] );
        }
        if( Math.abs( mx-mn ) > Number.EPSILON ) for( var i = 0 ; i < landmark_similarities.length ; i++ ) landmark_similarities[i]['similarities'] = ( landmark_similarities[i]['similarities']-mn ) / ( mx-mn );
        return res.sendSuccess(landmark_similarities);
    }catch(err){
        return res.sendError(err);
    }
};

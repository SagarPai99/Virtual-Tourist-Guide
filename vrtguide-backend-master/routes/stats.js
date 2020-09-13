const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '../.env') });

const db = require('../config/db');
const to = require('../utils/to');

exports.majorStats = async(req, res) => {
    try{
        let err, result;
        var data = {};
        [err,result] = await to(db.query("SELECT * FROM users"));
        if(err) return res.sendError(err);
        data['userData'] = {
            'userCount' : result.length,
            'users' : result
        };
        [err,result] = await to(db.query("SELECT * FROM landmark_visited_config"));
        if(err) return res.sendError(err);
        data['visitedConfig'] = {};
        for( var i = 0 ; i < result.length ; i++ ){
            if( !data['visitedConfig'].hasOwnProperty( result[i].lid ) ){
                data['visitedConfig'][result[i].lid] = {
                    'visitedCount' : 0,
                    'visitorUIDs' : [],
                    'visitorTime' : []
                };
            }
            data['visitedConfig'][result[i].lid]['visitedCount'] += 1;
            data['visitedConfig'][result[i].lid]['visitedUIDs'].push( result[i].uid );
            data['visitedConfig'][result[i].lid]['visitorTime'].push( result[i].visitedAt );
        }
        return res.sendSuccess(data);
    }catch(err){
        return res.sendError(err);
    }
};
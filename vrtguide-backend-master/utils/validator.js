const Joi = require('@hapi/joi');

module.exports = schema => (req, res, next) => {
    let data = {};
    if (Object.keys(req.query).length) data.query = req.query;
    if (Object.keys(req.params).length) data.params = req.params;
    if (Object.keys(req.body).length) data.body = req.body;
    const { error, value } = schema.validate(data, { abortEarly: false });
    if (error) {
        console.log(req.body);
        if (process.env.MODE == 'DEV') console.log(err);
        return res.json({
            success: false,
            msg: 'Invalid input'
        });
    }
    else {
        req.payload = value;
        next();
    }
};

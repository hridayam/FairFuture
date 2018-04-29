const express = require('express');
const router = express.Router();
const bodyParser = require('body-parser');
const uuid = require('uuid');
const aws = require('aws-sdk');

const config = require('../config/s3');
const s3 = new aws.S3();

s3.config.update({
    accessKeyId : config.accessKeyId,
    secretAccessKey : config.secretAccessKey,
    region : config.region
});

function getSignedURL(req, res, next) {
    var params = {
        Bucket : 'fairsfuture',
        Key : uuid.v4(),
        Expires : 1000,
        ContentType: 'image/jpeg'
    };
    s3.getSignedUrl('putObject', params, function(err, signedURL) {
        if (err) {
            console.log(err);
            return next(err);
        } else {
            return res.json({
                postURL: signedURL,
                getURL: signedURL.split("?")[0]
            });
        }
    });
}

router.get('/signed_url', (req, res, next) => {
    getSignedURL(req, res, next);
})

module.exports = router;
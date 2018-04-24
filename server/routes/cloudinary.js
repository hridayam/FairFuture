const express = require('express');
const router = express.Router();
const cloudinary = require('cloudinary').v2;
const bodyParser = require('body-parser');

const CLOUD_NAME = "dvt7vxvkz";
const API_Key = "322669748279172";
const API_Secret = "t5eJ2nmM8N4LLOXa9_nrW3pNllc";

router.post('/signature', function(req, res, next){
    var public_id = req.body.publicID;
    var folder = req.body.folder;
    var timestamp = Date.now()
    var params_to_sign = {
        "public_id": public_id,
        "folder": folder,
        'timestamp' : timestamp
    }
    /*var params_to_sign = {
        'timestamp' : 1346925631,
        "public_id": "abdbasdasda76asd7sa789",
        "api_key": "123456789012345",
    }*/
    var signature = cloudinary.utils.api_sign_request(params_to_sign, API_Secret)
    console.log(signature)
    res.status(200).json({
            "signature": signature,
            "public_id": public_id,
            "timestamp": timestamp,
            "api_key": API_Key
        });
});

module.exports = router;
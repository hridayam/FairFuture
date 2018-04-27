const express = require('express');
const router = express.Router();
const mongoose = require('mongoose');
const passport = require('passport');
const JwtStrategy = require('passport-jwt').Strategy;
const ExtractJwt = require('passport-jwt').ExtractJwt;
const jwt =  require('jsonwebtoken');
const bodyParser = require('body-parser');

const config = require('../config/database');
const User = require('../models/users');


// setting up file upload
const multer = require('multer');
const path = require('path');

// setting up storage
/*const storage = multer.diskStorage({
    destination: './public/uploads/',
    filename: function(req, file, cb) {
        cb(null, file.fieldname + '-' + Date.now() + path.extname(file.originalname))
    }
})*/

// Init upload
/*const upload = multer({
    storage: storage,
    fileFilter: function(req, file, cb){
        checkFileType(file, cb)
    }
}).single('myfile');*/

// check file type
function checkFileType(file, cb) {
    // Allowed file extentions
    const filetypes = /pdf/;
    // check ext
    const extname = filetypes.test(path.extname(file.originalname).toLowerCase());
    //check mime type
    const mimetype = filetypes.test(file.mimetype);

    if (mimetype && extname) {
        return cb(null, true);
    } else {
        cb('PDF files only');
    }
}

router.post('/resume', passport.authenticate('jwt', {session: false}), function(req, res, next) {
    user = req.user;
    // setting up storage
    const storage = multer.diskStorage({
        destination: './public/uploads/resume/' + user._id + '/',
        filename: function(req, file, cb) {
            cb(null, file.fieldname + '-' + Date.now() + path.extname(file.originalname))
        }
    })
    
    // Init upload
    const upload = multer({
        storage: storage,
        fileFilter: function(req, file, cb){
            checkFileType(file, cb)
        }
    }).single('myfile');

    upload(req, res, (err) => {
        if(err) {
            res.status(500).json({
                error: err
            })
        } else if(req.file == undefined) {
            res.status(500).json({
                error: "No File Selected"
            })
        }else {
            console.log(req.file)
            res.status(200).json({
                success: "resume uploaded",
                file: `http://localhost:3000/uploads/resume/${user._id}/${req.file.filename}`
            });
        }
    });
});

module.exports = router;
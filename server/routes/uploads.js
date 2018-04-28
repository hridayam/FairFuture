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
const Resume = require('../models/resumes');


// setting up file upload
const multer = require('multer');
const path = require('path');

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
    const fileName = req.body.fileName;
    const userId = req.user._id;

    const NewResume = new Resume({
        uploadedBy: userId,
        fileName: fileName
    });

    Resume.createResume(NewResume, function(err, resume) {
        if (err) {
            return res.status(500).json({
                error: err
            });
        } else {
            res.status(200).json({
                resume: resume
            });
        }
    })
});



router.put('/resume/:id', passport.authenticate('jwt', {session: false}), function(req, res, next) {
    const user = req.user;
    const id = req.params.id;
    console.log(id);

    Resume.getResumeById(id, function(err, resume) {
        if (err) throw err
        if(!resume) {
            return res.status(500).json({
                error: "Something went wrong"
            });
        } else {
            // setting up storage
            const storage = multer.diskStorage({
                destination: './public/uploads/resume/' + user._id + '/',
                filename: function(req, file, cb) {
                    cb(null, resume.fileName + '-' + Date.now() + path.extname(file.originalname))
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
                    const file = `http://localhost:3000/uploads/resume/${user._id}/${req.file.filename}`
                    Resume.addFileUrl(id,file, function() {
                        if (err) {
                            res.status(500).json({
                                err: error
                            });
                        } else {
                            res.status(200).json({
                                success: "resume uploaded",
                                file: file
                            });
                        }
                    });
                }
            });
        }

    });
});

module.exports = router;
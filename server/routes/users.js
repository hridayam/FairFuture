const express = require('express');
const mongoose = require('mongoose');
const router = express.Router();
const passport = require('passport');
const JwtStrategy = require('passport-jwt').Strategy;
const ExtractJwt = require('passport-jwt').ExtractJwt;
const jwt =  require('jsonwebtoken');
//const bodyParser = require('body-parser');

const config = require('../config/database');
const User = require('../models/users');

//let locUser;

// get one user
router.get('/profile', passport.authenticate('jwt', {session: false}), function(req, res, next){
    res.json({user: {
        id:                 req.user._id,
        email:              req.user.email,
        firstName:          req.user.firstName,
        lastName:           req.user.lastName,
        organizationName:   req.user.organizationName,
        role:               req.user.role,
        permitID:           req.user.permitID
    }});
});

router.post('/register', function(req, res) {
    const firstName = req.body.firstName;
    const lastName = req.body.lastName;
    const organizationName = req.body.organizationName;
    const email = req.body.email;
    const password = req.body.password;
    const confirmPassword = req.body.confirmPassword;

    // Validation
    req.checkBody('firstName', 'First Name is Required').notEmpty();
    req.checkBody('lastName', 'Last Name is Required').notEmpty();
    req.checkBody('email', 'email is Required').notEmpty();
    req.checkBody('email', 'email is not valid').isEmail();
    req.checkBody('password', 'password is Required').notEmpty();
    req.checkBody('confirmPassword', 'passwords do not match').equals(req.body.password);

    const errors = req.validationErrors();
    if(errors) {
        console.log(errors);
    } else {
        const newUser = new User({
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password
        });

        User.createUser(newUser, function(err, user){
            if(err) {
                res.status(500).json({success: false, msg: 'Failed to register User'});
            } else {
                res.status(201).json({success: true, msg: 'User Registered'});
            }
        });
        console.log('passed');
    }
});



router.post('/login', (req, res, next) => {
    const email = req.body.email;
    const password = req.body.password;

    User.getUserByEmail(email, function(err, user){
        if (err) throw err;
        if(!user){
            return res.json({success: false, msg: 'Either email or password is incorrect'})
        }

        User.comparePassword(password, user.password, (err, isMatch) => {
            if (err) throw err;
            if(isMatch) {
                const token = jwt.sign(user, config.secret, {
                    expiresIn: 604800 // 1 week
                });

                //console.log("logged in");
                res.json({
                    success: true,
                    token: 'JWT ' + token,
                    user: {
                        id: user._id,
                        email: user.email,
                        firstName: user.firstName,
                        lastName: user.lastName,
                        admin: user.admin
                    }
                })
            } else {
                return res.json({success: false, msg: 'Either email or password is incorrect'});
            }
        });
    });
});

module.exports = router;
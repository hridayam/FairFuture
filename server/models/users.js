const mongoose  = require ('mongoose');
const bcrypt = require ('bcryptjs');

const Schema = mongoose.Schema;

const validateEmail = function(email) {
    const re = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
    return re.test(email)
};

const userSchema = new Schema({
    firstName: {
        type: String,
        required: true
    },
    lastName: {
        type: String,
        required: true
    },
    email: {
        type: String,
        unique: true,
        trim: true,
        lowercase: true,
        required: true,
        validate: [validateEmail, 'Please fill a valid email address'],
        match: [/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/, 'Please fill a valid email address']
    },
    password: {
        type: String,
        required: true
    },
    role: {
        type: String,
        required: true
    },
    connections: [{
        type: String
    }]
});

const User = module.exports = mongoose.model('User', userSchema);

module.exports.createUser = function(newUser, callBack){
    bcrypt.genSalt(10, function(err, salt) {
        bcrypt.hash(newUser.password, salt, function(err, hash) {
            if (err) throw err;
            newUser.password = hash;
            newUser.save(callBack); 
        });
    });
}

module.exports.getUserByEmail = function(email, callback) {
    const query = {email: email};
    User.findOne(query, callback);
}

module.exports.getUserById = function(id, callback) {
    User.findById(id, callback);
}

module.exports.comparePassword = function(candidatePassword, hash, callback) {
    bcrypt.compare(candidatePassword, hash, function(err, isMatch) {
        if (err) throw err;
        callback(null, isMatch);
    });
}

module.exports.addConnection = function(id, applicantID, exists, callback) {
    User.findById(id, function(err, user) {
        if (err) throw err;
        if (user.connections.includes(`${applicantID}`)){
            var error = "already connected";
            exists(error);
            return;
        } else {
            User.update({ _id : id },
                { $push : { connections:applicantID } },
                function( err, result ) {
                    if ( err ) throw err;
                    User.update({ _id: applicantID },
                        {$push: { connections: id } },
                    function(err, res) {
                        if (err) throw err
                        callback(null, res)
                    });
            });
        }
    });
}

module.exports.getConnections = function(id, callBack) {
    var users = []
    User.findById(id, function(err, user) {
        if (err) throw err;
        var cursor = User.find({ _id : { $in : user.connections } }).cursor();
        cursor.on('data', function (user) {
            users.push(user)
        });
        cursor.on('close', function() {
            callBack(users);
          });
    });
}
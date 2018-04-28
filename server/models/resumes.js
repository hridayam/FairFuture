const mongoose  = require ('mongoose');
//const bcrypt = require ('bcryptjs');

const Schema = mongoose.Schema;

/*const validateEmail = function(email) {
    const re = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
    return re.test(email)
};*/

const resumeSchema = new Schema({
    uploadedBy: {
        type: String,
        required: true
    },
    fileName: {
        type: String,
        required: true
    },
    fileURL: {
        type: String
    },
    sharedWith: [{
        type: String
    }]
});

const Resume = module.exports = mongoose.model('Resume', resumeSchema);

module.exports.createResume = function(newResume, callBack){
    newResume.save(callBack);
}

module.exports.getResumeById = function(id, callback) {
    Resume.findById(id, callback);
}

/*module.exports.getUserByEmail = function(email, callback) {
    const query = {email: email};
    User.findOne(query, callback);
}

module.exports.comparePassword = function(candidatePassword, hash, callback) {
    bcrypt.compare(candidatePassword, hash, function(err, isMatch) {
        if (err) throw err;
        callback(null, isMatch);
    });
}*/

module.exports.addFileUrl = function(id, url, callback) {
    //user.connections.push(applicantID);
    Resume.update({ _id : id },
        { $set : {fileURL: url} },
        function( err, result ) {
            if ( err ) throw err;
            callback(null, result);
    });
}
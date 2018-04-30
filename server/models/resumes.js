const mongoose  = require ('mongoose');
var ObjectId = require('mongodb').ObjectID;
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
    newResume.sharedWith = [""];
    newResume.save(callBack);
}

module.exports.getResumeById = function(id, callback) {
    Resume.findById(id, callback);
}

/*module.exports.getUserByEmail = function(email, callback) {
    const query = {email: email};
    User.findOne(query, callback);
}*/

module.exports.addSharedWith = function(fileId, userId, exists ,callback) {
    Resume.findById(fileId, function(err, resume){
        if (err) throw err;
        //console.log(resume);
        //console.log(userId.toString());
        //console.log(resume.sharedWith.includes(userId.toString()));
        //console.log(resume.sharedWith);
        if (resume.sharedWith.includes(`${userId}`)){
            let error = "already shared";
            exists(error);
            return;
        } else {
            Resume.update(
                {_id : fileId},
                { $push : { sharedWith:userId } },
                function(err, res) {
                    if (err) callback(err, res);
                    Resume.getResumeById(fileId, callback)
                    //callback(null, res)
                }
            );
        }
    });
}

module.exports.getAllResume = function(id, callback) {
    resumes = [];
    //console.log(id)
    let cursor = Resume.find({ uploadedBy: id }).cursor();
    cursor.on('data', function (resume) {
        console.log(resume)
        let temp = {
            sharedWith: resume.sharedWith,
            id: resume._id,
            uploadedBy: resume.uploadedBy,
            fileName: resume.fileName,
            fileURL: resume.fileURL
        }
        resumes.push(temp)
    });
    cursor.on('close', function() {
        console.log(resumes)
        callback(resumes);
    });
}

module.exports.addFileUrl = function(id, url, callback) {
    //user.connections.push(applicantID);
    Resume.update({ _id : id },
        { $set : {fileURL: url} },
        function( err, result ) {
            if ( err ) throw err;
            callback(null, result);
    });
}

module.exports.getSharedResume = function(id, callback) {
    resumes = [];
    let cursor = Resume.find({sharedWith : id}).cursor();
    cursor.on('data', function (resume) {
        let temp = {
            sharedWith: resume.sharedWith,
            id: resume._id,
            uploadedBy: resume.uploadedBy,
            fileName: resume.fileName,
            fileURL: resume.fileURL
        }
        resumes.push(temp)
    });
    cursor.on('close', function() {
        callback(resumes);
    });
}
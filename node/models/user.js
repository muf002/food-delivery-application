const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true,
        minlength: 5,
        maxlength: 50
    },
    email: {
        type: String,
        required: true,
        minlength: 10,
        unique: true
    },
    password: {
        type: String,
        required: true
    },
});

const User = new mongoose.model('User', userSchema);

module.exports = User;
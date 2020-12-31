const mongoose = require('mongoose');

const restaurantSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true,
        minlength: 5
    },
    username:{
        type: String,
        required: true,
        unique: true,
    },
    isOpen:{
        type: Boolean,
    },
    password:{
        type:String,
        required:true,
        minlength:5
    }
});

const Restaurant = new mongoose.model('Restaurant', restaurantSchema);

module.exports = Restaurant;


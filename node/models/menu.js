const mongoose = require('mongoose');

const menuSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    price: {
        type: Number,
        required:true
    },
    restaurant:{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Restaurant'
    }
});

const Menu = new mongoose.model('Menu', menuSchema);

module.exports = Menu;
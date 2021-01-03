const mongoose = require('mongoose');

const orderSchema = new mongoose.Schema({
    product: {
        type: Array,
        required: true,
    },
    user:{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    restaurant:{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Restaurant',
        required:true
    },
    price:{
        type: Number,
        required: true
    },
    date: Date.now,
    isDelivered: Boolean
});

const Order = mongoose.model('Order', orderSchema);
module.exports = Order;
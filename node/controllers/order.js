const express = require('express');
const mongoose = require('mongoose');
const Restaurant = require('../models/restaurant');
const User = require('../models/user');
const Order = require('../models/order');
const router = express.Router();


router.post('/placeOrder', async(req, res)=>{
    console.log(req.body);
    const restaurant = await Restaurant.findOne({name: req.body.restaurant});
    console.log(restaurant);
    const user = await User.findOne({name:req.body.user});
    console.log(user);
    const order = new Order({
        product: req.body.product,
        user: user._id,
        restaurant: restaurant._id,
        price: req.body.price,
        address: req.body.address,
        isDelivered: false
    });
    try{
        const response = await order.save();
        console.log(response);
        res.send({success: true, msg:'party'});
    }catch(ex){
        res.send({success: false, msg:ex.message});
    }
})

router.get('/getOrderRes/:res', async(req, res)=>{
    const restaurant = await Restaurant.findOne({name: req.params.res});
    const order = await Order.find({restaurant: restaurant._id, isDelivered:false}).populate('user');
    res.send(order);
})

router.get('/getOrderHis/:res', async(req, res)=>{
    const restaurant = await Restaurant.findOne({name: req.params.res});
    const order = await Order.find({restaurant: restaurant._id, isDelivered:true}).populate('user');
    res.send(order);
})

router.get('/getOrderHisCust/:user', async(req, res)=>{
    const user = await User.findOne({name: req.params.user});
    const order = await Order.find({user: user._id}).populate('user');
    res.send(order);
})



router.put('/delivered/:id', async(req, res)=>{
    console.log(req.params);
    const order = await Order.updateOne({_id:req.params.id}, {$set:{isDelivered:true}});
    res.send(order);
})

router.delete('/orderDel/:id', async(req, res)=>{
    console.log(req.params.id);
    const order = await Order.deleteOne({_id:req.params.id});
    res.send(order);
})







module.exports = router;
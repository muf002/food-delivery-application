const express = require('express');
const mongoose = require('mongoose');
const Restaurant = require('../models/restaurant');
const Menu = require('../models/menu');
const router = express.Router();

router.post('/menuenter', async(req,res)=>{
    const restaurant = req.body.username;
    let rest = await Restaurant.findOne({username: restaurant});
    let menu = await Menu.findOne({ name: req.body.name });
    console.log(rest._id);
    if(menu){
        return res.status(200).json({"success": false, msg:"Menu already registered"});
    }else{
        menu = new Menu({
            name: req.body.name,
            price: req.body.price,
            restaurant: rest._id,
        });
    }
    const result = await menu.save();

    res.send(result);
    
});

router.get('/menu/:restaurant', async(req, res)=>{
    let rest = await Restaurant.findOne({ name: req.params.restaurant});
    let menu = await Menu.find({ restaurant: rest._id });
    console.log(menu);
    try{
        if (menu){
            res.send(menu);
        }
        else{
            res.send("Menu not found");
        }
    }catch(ex){
        res.send(ex.message);
    }
})

module.exports = router;
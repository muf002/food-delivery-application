const express = require('express');
const mongoose = require('mongoose');
const Restaurant = require('../models/restaurant');
const Menu = require('../models/menu');
const router = express.Router();

router.post('/menuEnter', async(req,res)=>{
    console.log(req.body);
    let menu = await Menu.findOne({ name: req.body.name });
    if(menu){
        return res.status(200).json({"success": false, msg:"Menu already registered"});
    }else{
        menu = new Menu({
            name: req.body.name,
            price: req.body.price,
            restaurant: req.body.restaurant,
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

router.get('/getMenuRes/:res', async(req, res)=>{
    const restaurant = await Restaurant.findOne({name: req.params.res});
    const menu = await Menu.find({restaurant: restaurant._id});
    res.send(menu);
})

router.delete('/menuDel/:id', async(req, res)=>{
    console.log(req.params.id);
    const menu = await Menu.deleteOne({_id:req.params.id});
    res.send(menu);
})

module.exports = router;
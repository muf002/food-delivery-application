const jwt = require('jsonwebtoken');
const express = require('express');
const mongoose = require('mongoose');
const bcrypt = require('bcrypt');
const Restaurant = require('../models/restaurant');
const router = express.Router();

router.get('/restaurants', async(req,res)=>{
    let rest = await Restaurant.find({isOpen:true}).select('-_id name');
    res.send(rest);
})

router.post('/restRegister', async (req, res)=>{
    let rest = await Restaurant.findOne({ username: req.body.username });
    if(rest){
        return res.status(200).json({"success": false, msg:"User already registered"});
    }else{
        rest = new Restaurant({
            name: req.body.name,
            username: req.body.username,
            isOpen:false,
            password: req.body.password,
        });
    }
    
    try{
        const salt = await bcrypt.genSalt(10);
        rest.password = await bcrypt.hash(rest.password, salt);
        const result = await rest.save();
        res.status(200).send({success: true, result:result});
    }
    catch(ex){
        res.status(200).send({success: false, msg:ex.message});
    }
});

router.post('/restlogin', async(req, res)=>{
    console.log(req.body);
    let rest = await Restaurant.findOne({ username: req.body.username });
    if (!rest){ res.json({"success":false, "msg":"Incorrect email or password"}); }
    else{
        const validPassword = await bcrypt.compare(req.body.password, rest.password);
        if (!validPassword){
            res.json({"success":false, "msg":"Incorrect email or password"});
        }else{
            const token = jwt.sign({ _id: rest._id, name: rest.name }, 'jwtPrivateKey');
            rest.isOpen = true;
            await rest.save();
            res.json({"success" : true, "token" : token});
        }
    }  
});

router.get('/restaurant/:token', async(req,res)=>{
    const token = req.params.token;
    if(!token){
        res.send('token not found');
    }
    else{
        try{
            const decoded = jwt.verify(token, 'jwtPrivateKey');
            res.send(decoded);
        }catch(ex){
            res.send(ex.message);
        }
    }
})

module.exports = router;
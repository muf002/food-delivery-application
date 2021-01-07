const jwt = require('jsonwebtoken');
const express = require('express');
const mongoose = require('mongoose');
const bcrypt = require('bcrypt');
const User = require('../models/user');
const router = express.Router();

router.post('/custRegister', async (req, res)=>{
    let user = await User.findOne({ email: req.body.email });
    if(user){
        return res.status(400).send('User already registered');
    }else{
        user = new User({
            name: req.body.name,
            email: req.body.email,
            password: req.body.password,
            type:req.body.type
        });
    }
    
    try{
        const salt = await bcrypt.genSalt(10);
        user.password = await bcrypt.hash(user.password, salt);
        const result = await user.save();
        res.status(200).send({success: true, result:result});
    }
    catch(ex){
        res.status(200).send({success: false, msg:ex.message});
    }
});

router.post('/login', async(req, res)=>{
    console.log(req.body);
    let user = await User.findOne({ email: req.body.email });
    if (!user){ res.json({"success":false, "msg":"Incorrect email or password"}); }
    else{
        const validPassword = await bcrypt.compare(req.body.password, user.password);
        if (!validPassword){
            res.json({"success":false, "msg":"Incorrect email or password"});
        }else{
            const token = jwt.sign({ _id: user._id, name: user.name }, 'jwtPrivateKey');
            res.json({"success" : true, "token" : token});
        }
    }  
});

router.get('/user/:token', async(req,res)=>{
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
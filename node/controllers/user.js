const jwt = require('jsonwebtoken');
const express = require('express');
const mongoose = require('mongoose');
const bcrypt = require('bcrypt');
const User = require('../models/user');
const router = express.Router();

router.post('/user', async (req, res)=>{
    let user = await User.findOne({ email: req.body.email });
    if(user){
        return res.status(400).send('User already registered');
    }
    user = new User({
        name: req.body.name,
        email: req.body.email,
        password: req.body.password
    });
    try{
        const salt = await bcrypt.genSalt(10);
        user.password = await bcrypt.hash(user.password, salt);
        const result = await user.save();
        res.status(200).send(result);
    }
    catch(ex){
        res.status(400).send(ex.message);
    }
});

router.post('/login', async(req, res)=>{
    console.log(req.body);
    let user = await User.findOne({ email: req.body.email });
    if (!user) res.status(400).send('Incorrect email or password');

    const validPassword = await bcrypt.compare(req.body.password, user.password);
    if (!validPassword) res.status(400).send('Incorrect email or password');

    const token = jwt.sign({ _id: user._id, name: user.name }, 'jwtPrivateKey');
    res.json({"success" : true, "token" : token});
});

module.exports = router;
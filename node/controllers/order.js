const jwt = require('jsonwebtoken');
const express = require('express');
const mongoose = require('mongoose');
const bcrypt = require('bcrypt');
const Restaurant = require('../models/order');
const router = express.Router();
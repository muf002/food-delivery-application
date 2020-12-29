const express = require('express');
const mongoose = require('mongoose');
const users = require('./controllers/user');
const app = express();
const port = 3000;

mongoose.connect('mongodb://localhost/first', {useNewUrlParser: true, useUnifiedTopology: true})
.then(()=>{
    console.log("Connected to MongoDb")
}).catch((err)=>{
    console.log(err);
});

app.use(express.json());
app.use('/', users);

// const courseSchema = new mongoose.Schema({
//     name: String,
//     author: String,
//     date: { type:Date, default: Date.now},
//     isPublished: Boolean
// });

// const Course = mongoose.model('login', courseSchema);

// async function createCourse () {
//     const course = new Course({
//         name: 'Computer design',
//         author: 'Usman Farooq',
//         isPublished: true
//     });
//     const result = await course.save();
//     console.log(result);
// };

// createCourse(); 






// app.get('/:id', (req, res)=>{
//     res.send(product[req.params.id]);
// });

app.listen(port, ()=>{
    console.log(`Server running on port ${port}`);
});
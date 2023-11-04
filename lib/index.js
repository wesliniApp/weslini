const express=require('express');
const app=express();

const userRouter = require('./user');
const AdminRouter=require('./admin');
//here we test json request and response so add json or user json

app.use(express.json());
app.use('/user' ,userRouter);
app.use('/admin' ,AdminRouter);


// Inscrire passager
app.get('/getChauffeurs', (req, res) => {
    AdminRouter.handle(req, res); 
});
app.put('/updateUserState', (req, res) => {
    AdminRouter.handle(req, res); 
});

// Inscrire passager
app.post('/utilisateurs', (req, res) => {
    userRouter.handle(req, res); 
});

// Inscrire passager
app.get('/verifier-numero', (req, res) => {
    userRouter.handle(req, res); 
});

app.put('/changePassword', (req, res) => {
    userRouter.handle(req, res); 
});




app.listen(8080,()=>console.log('your server is running in port 8080'));

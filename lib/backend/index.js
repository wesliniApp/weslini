const express=require('express');
const app=express();


//here we test json request and response so add json or user json

app.use(express.json());
const userRouter=require('./user');
app.use('/user' ,userRouter);

app.listen(3000,()=>console.log('your server is running in port 3000'));

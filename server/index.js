const express = require("express");
const http  = require("http");
const adminRouter = require('./routes/admin');
const authRouter  = require('./routes/auth');
const mongoose = require("mongoose");

const port = 4000;
const app = express();
const DB = "mongodb+srv://puneeth:puni123@cluster0.imdw0te.mongodb.net/?retryWrites=true&w=majority";


app.use(express.json());
app.use(authRouter);
app.use(adminRouter);

mongoose
.connect(DB)
.then(()=>{
    console.log("Database connection is successfull");
}).catch((e)=>{
    console.log(e);
})



app.listen(port,()=>{
    console.log("Waiting for connection");
});
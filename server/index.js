const express = require("express");
const http  = require("http");

const port = 3000;
const app = express();



app.listen(port,'0.0.0.0',()=>{
    console.log("Waiting for connection");
});
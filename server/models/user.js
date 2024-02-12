const mongoose = require("mongoose");
const { productSchema } = require("./product");

const userScheme = mongoose.Schema({
    name:{
        required : true,
        type :String,
        trim:true,
    },
    password:{
        required:true,
        type: String,
    },
    email:{
        required:true,
        type:String,
        trim:true,
        validate:{
            validator:(value) => {
                const re = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re);
            },
            message: "please enter the valid email",
        }
    },
    address:{
        type:String,
        deafault:"puneeth",
    },
    type:{
        type:String,
        default:'user',
    },
    cart :[
        {
            product: productSchema,
            quantity:{
                type:Number,
                required: true,
            }
        }
    ]
});

const User = mongoose.model("User",userScheme);

module.exports = User;
// IMPORT FROM PACKAGES

const mongoose = require("mongoose");
const express = require("express");

// IMPORT FROM OTHER FILES
const authRouter = require("./routes/auth");
const adminRouter = require("./routes/admin");
const productRouter = require("./routes/product");

//CONSTANTS
const mongooseUrl =
  "mongodb+srv://puneeth:Puni%40123@cluster0.bjcikza.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

// INIT
const PORT = 3000;
const app = express();

//MIDDLEWARE
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);

//CONNECTIONS
mongoose
  .connect(mongooseUrl)
  .then(() => {
    console.log("Connections to database has established !");
  })
  .catch((e) => {
    console.error(e);
  });

app.listen(PORT, "0.0.0.0", function () {
  console.log("Server is listing at the port " + PORT);
});

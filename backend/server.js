const express = require("express");
const app = express();
const cors = require('cors');

app.use(cors());
app.use(express.json());

// routes files
const donativeRoute = require("./routes/donativeRoute");
const reportsRoute = require("./routes/reportsRoute");
const campaignRoute = require('./routes/campaignRoute');

// routes used
app.use("/donative", donativeRoute);
app.use("/report", reportsRoute);
app.use('/campaign', campaignRoute);

app.get("/", (req, res)=>{
    res.send("Ejemplo");
});

const port = process.env.PORT || 5000;

app.listen(port, '127.0.0.1', () => {
    console.log('Server is running on port');
  });
  
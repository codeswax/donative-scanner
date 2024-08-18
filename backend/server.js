const express = require("express");
const app = express();

app.use(express.json());

// routes files
const donativeRoute = require("./routes/donativeRoute");
const reportsRoute = require("./routes/reportsRoute");


// routes used
app.use("/donative", donativeRoute);
app.use("/report", reportsRoute);


app.get("/", (req, res)=>{
    res.send("Ejemplo");
});

const port = process.env.PORT || 3000;

app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});
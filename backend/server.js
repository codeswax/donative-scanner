const express = require('express');
const app = express();
const cors = require('cors');

app.use(cors());
app.use(express.json());

// routes files
const donativeRoute = require('./routes/donativeRoute');
const campaignRoute = require('./routes/campaignRoute');
const categoryRoute = require('./routes/categoryRoute');

// routes used
app.use('/donative', donativeRoute);
app.use('/campaign', campaignRoute);
app.use('/category', categoryRoute);

app.get('/', (req, res)=>{
    res.send('Ejemplo');
});


const port = process.env.PORT || 5000;
/*'127.0.0.1'*/
app.listen(port, '127.0.0.1', () => {
    console.log('Server is running on port');
  });
  
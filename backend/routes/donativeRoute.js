// routes/donativeRoute
const express = require("express");
const { db } = require("../firebase");
const { createDonative, updateDonative, deleteDonative, getDonatives } = require("../controllers/donativeControllers");
const router = express.Router();

// get all donatives - Kevin Valle
router.get('/', getDonatives)

// create donative - Kevin Valle
router.post('/new', createDonative);

// update donative - Kevin Valle
router.put('/update/:id', updateDonative)

// delete donative - Kevin Valle
router.delete('/delete/:id', deleteDonative);

module.exports = router;
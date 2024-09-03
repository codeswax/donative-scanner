// routes/campaignRoute
const express = require("express");
const { db } = require("../firebase");
const { createCampaign, getAllCampaigns, getCampaign, updateCampaign, deleteCampaign, } = require("../controllers/campaignController");
const router = express.Router();

router.get('/', getAllCampaigns)

// get specific campaing
router.get('/:id', getCampaign)

// create campaing
router.post('/new', createCampaign);

// update campaing
router.put('/update/:id', updateCampaign)

// delete campaing
router.delete('/delete/:id', deleteCampaign);

module.exports = router;
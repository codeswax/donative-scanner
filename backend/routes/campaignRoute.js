// routes/campaignRoute
const express = require("express");
const { db } = require("../firebase");
const router = express.Router();

// get all campaign - Luis Quezada
router.get("/", async (req, res) => {
    try {
        const snapshot = await db.collection("campaign").get();
        const items = snapshot.docs.map((doc) => doc.data());
        res.status(200).json(items);
    } catch (error) {
        res.status(500).send("Cannot access data: " + error.message);
    }
});

// get specific campaign - Luis Quezada
router.get("/:id", async (req, res) => {
    try {
        const campaignId = req.params.id;
        const docRef = db.collection("campaign").doc(campaignId);
        const doc = await docRef.get();

        if (!doc.exists) {
            return res.status(404).send("Error displaying the campaign");
        }

        res.status(200).json(doc.data());
    } catch (error) {
        res.status(500).send("Cannot access data: " + error.message);
    }
});

// create campaign - Luis Quezada
router.post("/addCampaign/:id", async (req, res) => {
    try {
        const campaign = req.body;
        const campaignId = req.params.id
        const docRef = db.collection("campaign").doc(campaignId);
        await docRef.set(campaign);
        res.status(201).json({ message: "campaign added successfully", id: docRef.id });
    } catch (error) {
        res.status(500).send("Cannot access data: " + error.message);
    }
});
module.exports = router;
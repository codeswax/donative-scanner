// routes/donativeRoute
const express = require("express");
const { db } = require("../firebase");
const router = express.Router();

// get donatives - Kevin Valle
router.get("/", async (req, res) => {
    try {
        const snapshot = await db.collection("donative").get();
        const items = snapshot.docs.map(doc => doc.data());
        res.status(200).json(items);
      } catch (error) {
        res.status(500).send("Cannot access data: " + error.message);
      }
});

// get specific donative - Kevin Valle
router.get("/:id", async (req, res) => {
    try {
        const donativeId = req.params.id;
        const donRef = db.collection("donative").doc(donativeId);
        const don = await donRef.get();

        if (!don.exists) {
            return res.status(404).send("Error displaying the donative");
        }

        res.status(200).json(don.data());
    } catch (error) {
        res.status(500).send("Cannot access data: " + error.message);
    }
});

// create donative - Kevin Valle
router.post("/addDonative/:id", async (req, res) => {
    try {
        const donative = req.body;
        const donativeId = req.params.id
        const docRef = db.collection("donative").doc(donativeId);
        await docRef.set(donative);
        res.status(201).json({ message: "Donative scanned successfully", id: docRef.id });
    } catch (error) {
        res.status(500).send("Cannot access data: " + error.message);
    }
});

module.exports = router;
// routes/reportsRoute
const express = require("express");
const { db } = require("../firebase");
const router = express.Router();

// get all reports - Kevin Valle
router.get("/", async (req, res) => {
    try {
        const snapshot = await db.collection("report").get();
        const items = snapshot.docs.map((doc) => doc.data());
        res.status(200).json(items);
    } catch (error) {
        res.status(500).send("Cannot access data: " + error.message);
    }
});

// get specific report - Kevin Valle
router.get("/:id", async (req, res) => {
    try {
        const reportId = req.params.id;
        const docRef = db.collection("report").doc(reportId);
        const doc = await docRef.get();

        if (!doc.exists) {
            return res.status(404).send("Error displaying the report");
        }

        res.status(200).json(doc.data());
    } catch (error) {
        res.status(500).send("Cannot access data: " + error.message);
    }
});

// create a report with donatives - Kevin Valle
router.post("/addReport/:id", async (req, res) => {
    try {
        const report = req.body;
        const reportId = req.params.id
        const docRef = db.collection("report").doc(reportId);
        await docRef.set(report);
        res.status(201).json({ message: "Report created successfully", id: docRef.id });
    } catch (error) {
        res.status(500).send("Cannot access data: " + error.message);
    }
});

module.exports = router;
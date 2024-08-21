// routes/productsRoute
const express = require("express");
const { db } = require("../firebase");
const router = express.Router();

// get all products - Stefano Suarez
router.get("/", async (req, res) => {
    try {
        const snapshot = await db.collection("product").get();
        const items = snapshot.docs.map((doc) => doc.data());
        res.status(200).json(items);
    } catch (error) {
        res.status(500).send("Cannot access data: " + error.message);
    }
});

// get specific product - Stefano Suarez
router.get("/:id", async (req, res) => {
    try {
        const productId = req.params.id;
        const docRef = db.collection("product").doc(productId);
        const doc = await docRef.get();

        if (!doc.exists) {
            return res.status(404).send("Error displaying the product");
        }

        res.status(200).json(doc.data());
    } catch (error) {
        res.status(500).send("Cannot access data: " + error.message);
    }
});
module.exports = router;

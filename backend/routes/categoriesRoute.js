// routes/categoriesRoute
const express = require("express");
const { db } = require("../firebase");
const router = express.Router();

// create category - Stefano Suarez
router.post("/addCategory", async (req, res) => {
    const { collectionName, documentId, data } = req.body;
  
    try {
      let docRef;
      if (documentId) {
        docRef = db.collection(collectionName).doc(documentId);
      } else {
        docRef = db.collection(collectionName).doc();
      }

      await docRef.set(data);
      res.status(201).json({ message: "category added successfully", id:docRef.id });
    } catch (error) {
      res.status(500).send('Error adding category');
    }
});

module.exports = router;
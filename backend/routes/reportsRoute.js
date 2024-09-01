// routes/reportsRoute
const express = require("express");
const { createReport, getReports, getReport, updateReport, deleteReport } = require("../controllers/reportControllers");
const router = express.Router();

// get all reports - Kevin Valle
// router.get("/", async (req, res) => {
//     try {
//         const snapshot = await db.collection("report").get();
//         const items = snapshot.docs.map((doc) => doc.data());
//         res.status(200).json(items);
//     } catch (error) {
//         res.status(500).send("Cannot access data: " + error.message);
//     }
// });
router.get('/', getReports);

// get specific report - Kevin Valle
// router.get("/:id", async (req, res) => {
//     try {
//         const reportId = req.params.id;
//         const docRef = db.collection("report").doc(reportId);
//         const doc = await docRef.get();

//         if (!doc.exists) {
//             return res.status(404).send("Error displaying the report");
//         }

//         res.status(200).json(doc.data());
//     } catch (error) {
//         res.status(500).send("Cannot access data: " + error.message);
//     }
// });

// get specific report -Kevin Valle
router.get('/:id', getReport)

// create report - Kevin Valle
router.post('/new', createReport);

// update report - Kevin Valle
router.put('/update/:id', updateReport)

// delete report - Kevin Valle
router.delete('/delete/:id', deleteReport);

module.exports = router;
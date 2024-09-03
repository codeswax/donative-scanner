// routes/reportsRoute
const express = require("express");
const { createReport, getReports, getReport, updateReport, deleteReport } = require("../controllers/reportControllers");
const router = express.Router();

// get all reports - Kevin Valle
router.get('/', getReports);

// get specific report -Kevin Valle
router.get('/:id', getReport)

// create report - Kevin Valle
router.post('/new', createReport);

// update report - Kevin Valle
router.put('/update/:id', updateReport)

// delete report - Kevin Valle
router.delete('/delete/:id', deleteReport);

module.exports = router;
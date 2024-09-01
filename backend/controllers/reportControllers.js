const { db } = require('../firebase.js');
const Report = require('../models/reportModel.js');
const {
    collection,
    doc,
    addDoc,
    getDoc,
    getDocs,
    updateDoc,
    deleteDoc,
} = require('firebase/firestore');

// create report
const createReport = async (req, res, next) => {
    try {
        const data = req.body;
        await addDoc(collection(db, 'report'), data);
        res.status(200).send('Report created successfully.');
    } catch (error) {
        res.status(400).send(error.message);
    }
}

// get reports
const getReports = async (req, res, next) => {
    try {
        const reports = await getDocs(collection(db, 'report'));
        const reportArray = [];

        if (reports.empty) {
            res.status(400).send('No Reports found. Create a new one to continue.');
        } else {
            reports.forEach((doc) => {
                const report = new Report(
                    doc.id,
                    doc.data().reportDate,
                    doc.data().donative,
                );
                reportArray.push(report);
            });

            res.status(200).send(reportArray);
        }
    } catch (error) {
        res.status(400).send(error.message);
    }
};

// get specific report
const getReport = async (req, res, next) => {
    try {
        const id = req.params.id;
        const report = doc(db, 'report', id);
        const data = await getDoc(report);
        if (data.exists()) {
            res.status(200).send(data.data());
        } else {
            res.status(404).send('Report not found.');
        }
    } catch (error) {
        res.status(400).send(error.message);
    }
};

// update report
const updateReport = async (req, res, next) => {
    try {
        const id = req.params.id;
        const data = req.body;
        const report = doc(db, 'report', id);
        await updateDoc(report, data);
        res.status(200).send('Report updated successfully.');
    } catch (error) {
        res.status(400).send(error.message);
    }
};

// delete report
const deleteReport = async (req, res, next) => {
    try {
        const id = req.params.id;
        await deleteDoc(doc(db, 'report', id));
        res.status(200).send('Report deleted successfully.');
    } catch (error) {
        res.status(400).send(error.message);
    }
};

module.exports = {
    createReport,
    getReports,
    getReport,
    updateReport,
    deleteReport,
};

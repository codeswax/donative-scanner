const { db } = require('../firebase.js');
const {
    collection,
    doc,
    addDoc,
    getDoc,
    getDocs,
    updateDoc,
    deleteDoc,
    setDoc,
} = require('firebase/firestore');

// create report
const createReport = async (req, res, next) => {
    try {
        const { campaign, donatives, reportDate } = req.body;

        if (!campaign || !donatives || !reportDate) {
            return res.status(400).send('Datos inválidos en la solicitud.');
        }

        // Crear una referencia al documento de campaña usando el ID proporcionado
        const campaignRef = doc(db, 'campaign', campaign);

        // Asegúrate de que el documento de campaña existe antes de proceder
        await setDoc(campaignRef, { name: "Nombre de la Campaña" }, { merge: true });

        // Crear el documento del reporte
        const reportData = {
            campaign: campaignRef.id,
            donatives: donatives,
            reportDate: reportDate
        };

        await addDoc(collection(db, 'report'), reportData);

        res.status(200).send('Report created successfully.');
    } catch (error) {
        console.error('Error creating report:', error);
        res.status(400).send(error.message);
    }
};


// get reports
const getReports = async (req, res, next) => {
    
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

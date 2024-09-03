const { db } = require('../firebase.js');
const {
    collection,
    doc,
    setDoc,
    getDoc,
    getDocs,
    updateDoc,
    deleteDoc,
} = require('firebase/firestore');

// create campaign
const createCampaign = async (req, res, next) => {
    try {
        const data = req.body;
        await setDoc(doc(db, "campaign", data.id), data.content);
        res.status(201).send('Created a new successfully.');
    } catch (error) {
        res.status(400).send(error.message);
    }
}

// get campaign
const getAllCampaigns = async (req, res, next) => {
    try {
        const campaigns = await getDocs(collection(db, 'campaign'));
        const campaignsArray = [];
        campaigns.forEach((doc) => campaignsArray.push({ id: doc.id, ...doc.data() }));
        res.status(200).json(campaignsArray);
    } catch (error) {
        res.status(400).send(error.message);
    }
};

// get specific campaign
const getCampaign = async (req, res, next) => {
    try {
        const id = req.params.id;
        const campaign = doc(db, 'campaign', id);
        const data = await getDoc(campaign);
        if (data.exists()) {
            res.status(200).json(data.data());
        } else {
            res.status(404).send('Campaign not found.');
        }
    } catch (error) {
        res.status(400).send(error.message);
    }
};

// update campaign
const updateCampaign = async (req, res, next) => {
    try {
        const id = req.params.id;
        const data = req.body;
        const campaign = doc(db, 'campaign', id);
        await updateDoc(campaign, data);
        res.status(200).send('Campaign updated successfully.');
    } catch (error) {
        res.status(400).send(error.message);
    }
};

// delete campaign
const deleteCampaign = async (req, res, next) => {
    try {
        const id = req.params.id;
        await deleteDoc(doc(db, 'campaign', id));
        res.status(200).send('Campaign deleted successfully.');
    } catch (error) {
        res.status(400).send(error.message);
    }
};

module.exports = {
    createCampaign,
    getAllCampaigns,
    getCampaign,
    updateCampaign,
    deleteCampaign,
};
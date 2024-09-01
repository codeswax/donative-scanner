const { db } = require('../firebase.js');
const {
    collection,
    doc,
    addDoc,
    getDoc,
    getDocs,
    updateDoc,
    deleteDoc,
} = require('firebase/firestore');

// create donative (scan)
const createDonative = async (req, res, next) => {
    try {
        const data = req.body;
        await addDoc(collection(db, 'donative'), data);
        res.status(200).send('Donative created successfully.');
    } catch (error) {
        res.status(400).send(error.message);
    }
}

// get donatives
const getDonatives = async (req, res, next) => {
    try {
        const donatives = await getDocs(collection(db, 'donative'));
        const donativeArray = [];

        if (donatives.empty) {
            res.status(400).send('No Donatives found. Start scanning.');
        } else {
            for (const doc of donatives.docs) {
                const categoryRef = doc.data().category
                let category = {}
                if (categoryRef != null) {
                    category = await getDoc(categoryRef)
                } else {
                    res.status(400).send('Unknown category. Try entering it first.');
                }
                const donative = {
                    id: doc.id,
                    brand: doc.data().brand,
                    category: category.data(),
                    description: doc.data().description,
                    quantity: doc.data().quantity
                };
                donativeArray.push(donative);
            }
            res.status(200).send(donativeArray);
        }
    } catch (error) {
        res.status(400).send(error.message);
    }
};

// get specific donative
const getDonative = async (req, res, next) => {
    try {
        const id = req.params.id;
        const donative = doc(db, 'donative', id);
        const data = await getDoc(donative);
        if (data.exists()) {
            res.status(200).send(data.data());
        } else {
            res.status(404).send('Donative not found.');
        }
    } catch (error) {
        res.status(400).send(error.message);
    }
};

// update donative
const updateDonative = async (req, res, next) => {
    try {
        const id = req.params.id;
        const data = req.body;
        const donative = doc(db, 'donative', id);
        await updateDoc(donative, data);
        res.status(200).send('Donative updated successfully.');
    } catch (error) {
        res.status(400).send(error.message);
    }
};

// delete donative
const deleteDonative = async (req, res, next) => {
    try {
        const id = req.params.id;
        await deleteDoc(doc(db, 'donative', id));
        res.status(200).send('Donative deleted successfully.');
    } catch (error) {
        res.status(400).send(error.message);
    }
};

module.exports = {
    createDonative,
    getDonatives,
    getDonative,
    updateDonative,
    deleteDonative,
};

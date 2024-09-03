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

const createDonative = async (req, res, next) => {
    try {
        const donatives = req.body;
        await Promise.all(donatives.map(async (donative) => {
            const { category, ...donativeData } = donative;  
            const categoryRef = doc(collection(db, category['name']));
            await setDoc(categoryRef, category);
            const donativeWithCategory = {
                ...donativeData,
                category: {
                    id: categoryRef.id,
                    name: category['name']
                }          
            };
            await addDoc(collection(db, 'donative'), donativeWithCategory);
        }));
        res.status(200).send('Donative created successfully.');
    } catch (error) {
        res.status(400).send(error.message);
    }
};

// get donatives
const getDonatives = async (req, res, next) => {
    try {
        const donativeArray = [];
        const donativeCollectionRef = collection(db, 'donative');
        const donativeSnapshot = await getDocs(donativeCollectionRef);
        for (const doc of donativeSnapshot.docs) {
            const donative = {
                id: doc.id,
                brand: doc.data().brand,
                description: doc.data().description,
                quantity: doc.data().quantity,
                category: doc.data().category,
            };
            donativeArray.push(donative);
        }
        res.status(200).send(donativeArray);
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
        const donativeRef = doc(db, 'donative', id);
        const donativeDoc = await getDoc(donativeRef);

        if (donativeDoc.exists()) {
            const { category } = donativeDoc.data();
            if (category && category.id && category.name) {
                const categoryRef = doc(db, category.name, category.id);
                await deleteDoc(categoryRef);
            }
            await deleteDoc(donativeRef);

            res.status(200).send('Donative and associated category deleted successfully.');
        } else {
            res.status(404).send('Donative not found.');
        }
    } catch (error) {
        res.status(400).send(error.message);
    }
};


module.exports = {
    createDonative,
    getDonatives,
    updateDonative,
    deleteDonative,
};

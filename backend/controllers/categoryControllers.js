const { db } = require('../firebase.js');
const {
    collection,
    doc,
    getDoc,
    getDocs,
    deleteDoc,
    setDoc,
} = require('firebase/firestore');

const getCategory = async (req, res, next) => {
    try {
        const categoryArray = [];
        const categoryCollectionRef = collection(db, 'category');
        const categorySnapshot = await getDocs(categoryCollectionRef);
        for (const doc of categorySnapshot.docs) {
            const category = {
                id: doc.id,
                name: doc.data().name,
                description: doc.data().description,
                guideProducts: doc.data().guideProducts
            };
            categoryArray.push(category);
        }
        res.status(200).send(categoryArray);
    } catch (error) {
        res.status(400).send(error.message);
    }
};


// create campaign
const createCategory = async (req, res, next) => {
    try{
        const data = req.body;
        await setDoc(doc(db, "category", data.id), data.content);
        res.status(201).send('Created a new category successfully.');
    } catch (error) {
        res.status(400).send(error.message);
    }
};

// delete category
const deleteCategory = async (req, res, next) => {
    try {
        const id = req.params.id;
        const categoryRef = doc(db, 'category', id);
        const categoryDoc = await getDoc(categoryRef);

        if (categoryDoc.exists()) {
            await deleteDoc(categoryRef);

            res.status(200).send('Category deleted successfully.');
        } else {
            res.status(404).send('Category not found.');
        }
    } catch (error) {
        res.status(400).send(error.message);
    }
};

module.exports = {
    createCategory,
    getCategory,
    deleteCategory,
};
const { db } = require('../firebase.js');
const {
    collection,
    doc,
    addDoc,
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
            };
            categoryArray.push(category);
        }
        res.status(200).send(categoryArray);
    } catch (error) {
        res.status(400).send(error.message);
    }
};

const createCategory = async (req, res, next) => {
    try{
        const { name, description } = req.body;

        // Crear un documento de categoría en la colección 'categories'
        const categoryRef = await addDoc(collection(db, 'category'), {
            name: name,
            description: description
        });

        res.status(200).send(`Category created successfully with ID: ${categoryRef.id}`);
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
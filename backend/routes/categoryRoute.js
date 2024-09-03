// routes/categoriesRoute
const express = require("express");
const { db } = require("../firebase");
const { createCategory, deleteCategory, getCategory } = require("../controllers/categoryControllers");
const router = express.Router();

// create category - Stefano Suarez
router.post('/new', createCategory);

// get all categories - Stefano Suarez
router.get('/', getCategory)

// delete donative - Stefano Suarez
router.delete('/delete/:id', deleteCategory);

module.exports = router;
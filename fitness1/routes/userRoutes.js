const express = require("express");
const router = express.Router();
const userController = require("../controllers/userController");

router.get("/:username/dashboard", userController.getDashboard);

router.post("/:username/steps", userController.updateSteps);

router.post('/:username/book-test', userController.bookHealthTest);

router.post("/register", userController.registerUser);

router.post("/login", userController.loginUser);

module.exports = router;
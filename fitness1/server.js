console.log("✅ Server file is working!");
const express = require("express");
const cors = require("cors");
const bodyParser = require("body-parser");

const app = express();


app.use(cors());
app.use(express.json());
app.use(bodyParser.json());


// ROUTES
const userRoutes = require('./routes/userRoutes');
app.use('/api/user', userRoutes);

// Default route
app.get("/", (req, res) => {
  res.send("Welcome to FitHealth API backend!");
});

const PORT = 3000;
app.listen(PORT, () => {
  console.log(`✅ Server running at http://localhost:${PORT}`);
});
app.all('*', (req, res) => {
  res.status(404).send(`Cannot ${req.method} ${req.url}`);
});

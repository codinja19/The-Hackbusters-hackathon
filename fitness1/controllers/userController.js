const fs = require('fs');
const path = require('path');

// Read user data from JSON file
function readData() {
  const filePath = path.join(__dirname, '../data.json');
  const rawData = fs.readFileSync(filePath);
  return JSON.parse(rawData);
}

// 📄 Get user dashboard
exports.getDashboard = (req, res) => {
  const username = req.params.username;
  const users = readData();

  if (!users[username]) {
    return res.status(404).json({ message: "User not found" });
  }

  res.json(users[username]);
};

// 📩 Update steps and handle rewards
exports.updateSteps = (req, res) => {
  const username = req.params.username;
  const { steps, calories } = req.body;

  const filePath = path.join(__dirname, '../data.json');
  const rawData = fs.readFileSync(filePath);
  const users = JSON.parse(rawData);

  const user = users[username];
  if (!user) {
    return res.status(404).json({ message: "User not found" });
  }

  const today = new Date().toISOString().split('T')[0];
  user.lastStepDate = user.lastStepDate || today;
  user.stepsToday = user.stepsToday || 0;
  user.rewards = user.rewards || 0;

  if (user.lastStepDate !== today) {
    user.stepsToday = 0;
    user.lastStepDate = today;
    user.rewardedToday = false;
  }

  user.stepsToday += steps;
  if (steps !== undefined) user.steps = (user.steps || 0) + steps;
  if (calories !== undefined) user.calories = calories;

  if (user.stepsToday >= 7000 && !user.rewardedToday) {
    user.rewards += 1;
    user.rewardedToday = true;
    console.log(`🎉 User ${username} earned 1 reward for reaching daily goal`);
  }

  fs.writeFileSync(filePath, JSON.stringify(users, null, 2));

  res.json({
    message: "Steps and daily rewards updated successfully",
    stepsToday: user.stepsToday,
    steps: user.steps,
    calories: user.calories,
    rewards: user.rewards,
    today: user.lastStepDate
  });
};
exports.bookHealthTest = (req, res) => {
    // 📅 Book a health test
  const username = req.params.username;
  const filePath = path.join(__dirname, '../data.json');
  const rawData = fs.readFileSync(filePath);
  const users = JSON.parse(fs.readFileSync(filePath));

  const user = users[username];
  if (!user) {
    return res.status(404).json({ message: "User not found" });
  }

  if (user.rewards < 5) {
    return res.status(403).json({
      message: "Not enough points. You need at least 5 rewards to unlock a free health checkup."
    });
  }

  if (user.hasFreeHealthCheckup) {
    return res.status(409).json({ message: "You've already claimed your free health checkup." });
  }

  //  Unlocking of the reward
  user.hasFreeHealthCheckup = true;
  user.rewards -= 5;

  fs.writeFileSync(filePath, JSON.stringify(users, null, 2));

  res.json({
    message: "🎉 Free health checkup unlocked successfully!",
    remainingRewards: user.rewards
  });
};
exports.registerUser = (req, res) => {
  const { username,password } = req.body;

  const filePath = path.join(__dirname, '../data.json');
  const data = JSON.parse(fs.readFileSync(filePath));

  if (data[username]) {
    return res.status(409).json({ message: "Username already exists" });
  }

  // Add new user with default values
  data[username] = {
    password: password,
    steps: 0,
    stepsToday: 0,
    lastStepDate: new Date().toISOString().split('T')[0],
    rewardedToday: false,
    goal: 7000,
    calories: 0,
    rewards: 0,
    hasFreeHealthCheckup: false
  };

  fs.writeFileSync(filePath, JSON.stringify(data, null, 2));
  res.json({ message: `✅ User '${username}' registered successfully.` });
};
exports.loginUser = (req, res) => {
  const { username, password } = req.body;

  const filePath = path.join(__dirname, '../data.json');
  const rawData = fs.readFileSync(filePath);
  const users = JSON.parse(rawData);

  const user = users[username];

  if (!user) {
    return res.status(404).json({ message: "User not found" });
  }

  if (user.password !== password) {
    return res.status(401).json({ message: "Incorrect password" });
  }

  // Success
  res.json({
    message: "Login successful",
    username: username
    // optionally: add a token here for real auth
  });
};
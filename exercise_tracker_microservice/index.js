const express = require("express");
const app = express();
const cors = require("cors");
const bodyParser = require("body-parser");
const mongoose = require("mongoose");
require("dotenv").config();

app.use(cors());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(express.static("public"));

// Connect to MongoDB
mongoose.connect(process.env.MONGO_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});
const db = mongoose.connection;
db.on("error", console.error.bind(console, "connection error:"));
db.once("open", () => console.log("Connected to MongoDB"));

// Create an Exercise model
const exerciseSchema = new mongoose.Schema({
  userId: { type: mongoose.Schema.Types.ObjectId, ref: "User" },
  description: String,
  duration: Number,
  date: String,
});

const Exercise = mongoose.model("Exercise", exerciseSchema);

// Create a User model
const userSchema = new mongoose.Schema({
  username: String,
  log: [{ type: mongoose.Schema.Types.ObjectId, ref: "Exercise" }],
});

const User = mongoose.model("User", userSchema);


app.get("/", (req, res) => {
  res.sendFile(__dirname + "/views/index.html");
});

app.post("/api/users", async (req, res) => {
  const username = req.body.username;
  const newUser = new User({ username: username });
  await newUser.save();
  res.json({ username: newUser.username, _id: newUser._id });
});

app.get("/api/users", async (req, res) => {
  const users = await User.find().select("username _id");
  res.json(users);
});

app.post("/api/users/:_id/exercises", async (req, res) => {
  const userId = req.params._id;
  const { description, duration, date } = req.body;
  let dateString = ""
  if (!date) {
    dateString = new Date().toDateString();
  } else {
    dateString = new Date(date).toDateString();
  }
  const newExercise = new Exercise({
    userId: userId,
    description: description,
    duration: duration,
    date: dateString,
  });
  await newExercise.save();
  const user = await User.findById(userId);
  user.log.push(newExercise._id);
  await user.save();
  res.json({
    _id: userId,
    username: user.username,
    date: new Date(newExercise.date).toDateString(),
    duration: newExercise.duration,
    description: newExercise.description,
  });
});

app.get("/api/users/:_id/logs", async (req, res) => {
  const limit = req.query.limit;
  const from = req.query.from;
  const to = req.query.to;
  const userId = req.params._id;
  
  const user = await User.findById(userId).populate("log");
  const count = user.log.length;
  let log = user.log.map((exercise) => ({
    description: exercise.description,
    duration: exercise.duration,
    date: new Date(exercise.date).toDateString(),
  }));

  if (limit) {
    log = log.slice(0, limit);
  }

  if (from) {
    log = log.filter((exercise) => new Date(exercise.date) >= new Date(from));
  }

  if (from && to) {
    log = log.filter(
      (exercise) => new Date(exercise.date) <= new Date(to) && new Date(exercise.date) >= new Date(from)
    );
  }

  res.json({
    _id: userId,
    username: user.username,
    count: count,
    log: log,
  });
});

const listener = app.listen(process.env.PORT || 3000, () => {
  console.log("Your app is listening on port " + listener.address().port);
});

const express = require("express");
const app = express();
const port = process.env.PORT;
const helmet = require("helmet");
const cors = require("cors");
const BD = require("./config/dbconfig");

// Utilisation de express.json() pour analyser les corps de requête JSON
app.use(express.json());
app.use(cors());

app.use(helmet());
app.use(express.urlencoded({ extended: true }));

//** importation des routes */

const auth_router = require("./routes/auth.route");
const inscription_route = require("./routes/inscription.route");
const user_route = require("./routes/user.route");
const education_route = require("./routes/education.route");
const competence_route = require("./routes/competence.route");
const loisir_route = require("./routes/loisir.route");
const langue_route = require("./routes/langue.route");
const experience_route = require("./routes/experience.route");
const resume_route = require("./routes/resume.route");
const projet_route = require("./routes/projet.route");
const certification_route = require("./routes/certification.route");

//**mise en place du routage */

app.get("/", (req, res) => {
  res.send("chimi ");
});

app.use("/auth", auth_router);
app.use("/inscription", inscription_route);
app.use("/user", user_route);
app.use("/education", education_route);
app.use("/competence", competence_route);
app.use("/loisir", loisir_route);
app.use("/langue", langue_route);
app.use("/experience", experience_route);
app.use("/resume", resume_route);
app.use("/projet", projet_route);
app.use("/certification", certification_route);
//static Images Folder

app.use("/Images", express.static("./Images"));

//*** lancement du serveur */

BD.sequelize
  .authenticate()
  .then(() => {
    console.log("connexion a la BD  ok");
  })
  .then(() => {
    app.listen(port, () => {
      console.log(`server: http://localhost:${port}`);
    });
  })
  .catch((error) => {
    console.log("la connexion a la BD a echouee", error);
  });

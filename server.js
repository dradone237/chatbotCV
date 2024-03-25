const express = require("express") ;
const app = express();
const port = process.env.PORT;
const cors = require("cors") ;
const bodyParser = require("body-parser");
const db= require("./config/dbconfig")

const checktokenmaddleware = require("./jesonwebtoken/check")
// Utilisation de express.json() pour analyser les corps de requête JSON
app.use(bodyParser.json());
app.use(cors());



//** importation des routes */

const auth_router = require("./routes/auth.route") ;
const users_route = require("./routes/users.route") ;
const info_perso_route = require("./routes/info_perso.route") ;
const education_route = require("./routes/education.route");
const competence_route = require("./routes/competence.route") ;
const loisir_route = require("./routes/loisir.route") ;
const langue_route = require("./routes/langue.route") ;
const experience_route = require("./routes/experience.route") ;
const resume_route = require("./routes/resume.route");
const projet_route = require("./routes/projet.route");
const certification_route = require("./routes/certification.route");
const dialogue_route = require("./routes/dialogue.route");

const  genereteCV_route = require("./routes/generateCV.route");

//**mise en place du routage */

app.get("/", (req, res) => {
  res.send("chimi ");
});

app.use("/auth", auth_router);
app.use("/inscription", users_route);
app.use("/perso",checktokenmaddleware, info_perso_route);
app.use("/education",checktokenmaddleware, education_route);
app.use("/competence",checktokenmaddleware, competence_route);
app.use("/loisir",checktokenmaddleware, loisir_route);
app.use("/langue",checktokenmaddleware, langue_route);
app.use("/experience",checktokenmaddleware, experience_route);
app.use("/resume",checktokenmaddleware, resume_route);
app.use("/projet",checktokenmaddleware, projet_route);
app.use("/certification",checktokenmaddleware, certification_route);
app.use("/dialogue",checktokenmaddleware, dialogue_route)
app.use("/generatecv",checktokenmaddleware, genereteCV_route);

//*** lancement du serveur */

db.sequelize
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

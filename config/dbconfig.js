const { Sequelize } = require("sequelize");

//**** connexion a la bd */
const sequelize = new Sequelize(
  "curriculum",
  process.env.DB_USER,
  process.env.DB_PASSWORD,
  {
    host: process.env.DB_HOST,
    dialect: "mysql",
    logging: false,
  }
);

//**mise en place des relation */

const db = {};
db.sequelize = sequelize;
db.Inscription = require("../models/Inscription")(sequelize);
db.User = require("../models/user")(sequelize);
db.Education = require("../models/education")(sequelize);
db.Competence = require("../models/competence")(sequelize);
db.Loisir = require("../models/loisir")(sequelize);
db.Langue = require("../models/langue")(sequelize);
db.Experience = require("../models/experience")(sequelize);
db.Resume = require("../models/remuse")(sequelize);
db.Projet = require("../models/projet")(sequelize);
db.Certification = require("../models/certification")(sequelize);
//**** synchronisation */

sequelize.sync({ alter: true });
console.log("All models were synchronized successfully.");

module.exports = db;

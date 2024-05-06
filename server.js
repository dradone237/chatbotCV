const express = require("express") ;
const app = express();
const port = process.env.PORT;
const cors = require("cors") ;
const bodyParser = require("body-parser");
const db= require("./config/dbconfig")
const swaggerJSDoc = require('swagger-jsdoc');
const swaggerUi = require('swagger-ui-express');
const path = require('path');
const axios = require("axios")
const User = db.Users
const Info_perso = db.Info_perso
const Resume = db.Resume


const  {formatCompetence,formatEducation,formatExperience,formatCertification,formatLangues,formatResume,formatLoisir,formatPerso} = require("./utils")
// socket.io

var server = require('http').Server(app);
var io = require('socket.io')(server);

//socket.io

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

// mise en place de la documentation swagger



const swaggerDefinition = {
  openapi: '3.0.0',
  info: {
    title: 'Express API POUR LA  GENERETION DE CV',
    version: '1.0.0',
    description:
    "C'est une REST API faite avec Express permettant d'enregistrer les informations de l'utilisateur en base de données dans le cadre d'une application de génération de CV"
  },
  servers: [
    {
      url: 'http://localhost:3000',
      description: 'serveur de developpement',
    },
  ],

  
};

const options = {
  swaggerDefinition,
  // chemin vers mes routes 
  apis: ['./routes/*.js'],
};

const swaggerSpec = swaggerJSDoc(options);

app.use('/docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec));

//  fin de la mise en place de la documentation swagger...


// mise en place de socket.io pour une communication bidirectionnelle



//Whenever someone connects this gets executed



io.on('connection',  function(socket){
   
  // const  userId = socket.handshake.query.userId
  
  // Génération du résumé
//  socket.on('resumeClientEvent', async function(data) {
    
//    const users = data.user;
//    console.log('Utilisateur:', users)
   
//    let user = await User.findOne({
//     where: { id:data.user },
//     include: [
//       {
//         model: db.Certification,
//         attributes: { exclude: ['userId'] },
//       },
//       {
//         model: db.Competence,
//         attributes: { exclude: ['userId'] },
//       },
//       {
//         model:  db.Education,
//         attributes: { exclude: ['userId'] },
//       },
//       {
//         model: db.Experience,
//         attributes: { exclude: ['userId'] },
//       },
     
//     ],
//   });
//   // destructuration des information de l'utilisateur dans des variables
// let user_final = {certifications,competences,education,experiences} = user
//  // recuperation de la profession d'un utilisateur

//  const profession = await Info_perso.findOne({
//   where: {
//     id:data.user
//   },
//   attributes: ['profession']
// })
// console.log(profession.dataValues.profession)
// //fonction qui permet de faire le formatage du prompt pour l'IA
// const formatage = (certifications,competences,education,experiences)=>{
//   certificats = formatCertification(certifications)
//    competences =  formatCompetence(competences)
//    educations =  formatEducation(education) 
//    experiences =  formatExperience(experiences)
//    // ${educations} ,${experiences},${certificats}
//    return ` Étant donné mes compétences suivantes: ${competences},${educations},${experiences},${certificats} es ce que tu peux faire une bref presentation de moi , J'ai une solide expérience en tantque  ${profession.dataValues.profession},ainsi qu'une passion pour l'innovation. J'aimerais une présentation qui mette en valeur mes compétences, mon expérience et ma motivation à relever de nouveaux défis , rédige une présentation cohérente et attrayante , je veux sa en un seul paragraphe,Je préfère une approche naturelle, sans poésie, utilise uniquement les competences que je te donne n'augmente rien, et une seul version en un seul bloc.`
   
// }


// // appelle de la fonction qui permet de faire le formatage du prompt pour l'IA
// const resultat = formatage(certifications,competences,education,experiences)
// const datas = async () => {
//   try {
//    const response = await axios.post(' https://generativelanguage.googleapis.com/v1/models/gemini-pro:generateContent?key= AIzaSyCJKdylpxbw14hTo86p4XFi4gjP-vTBxRs'
//    , {
//      "contents": [{
//        "parts":[{
//          "text": resultat
//        }]}]}
   
//     );
   

//     return response;
//  } catch (error) {
//    console.error("Erreur lors de la requête:", error);
//    throw error; // Vous pouvez gérer l'erreur ici ou la propager
//   }
// };

// (async () => {
//  try {
//    const response = await datas();
//    //console.log("Réponse de la requête:",  JSON.stringify(response.data.candidates[0].content.parts[0].text, null, 2));
//    // const donnees = response.data.choices[0].message.content
  
//   const  donnees =  response.data.candidates[0].content.parts[0].text
//     const resume = await db.Resume.create({resume:donnees ,userId:data.user})
//   socket.emit('resumeEvent',{donnees})
//    // Faites ce que vous voulez avec la réponse ici
//  } catch (error) {
//    console.error("Erreur lors de l'utilisation de la fonction:", error);
//  }
// })();


// });

  // Génération du plan de carrière.
// socket.on('planClientEvent', async(data)=>{
 
//   let user = await User.findOne({
//     where: { id:data.user },
//     include: [
//       {
//         model: db.Competence,
//         attributes: { exclude: ['userId'] },
//       },]})
//     const user_info= {competences} = user
//     const message = data.domaine
//     // recuperation de la profession d'un utilisateur
//  const profession = await Info_perso.findOne({
//   where: {
//     id:data.user
//   },
//    attributes: ['profession']
//  })
//         
//     // formatage du message pour envoyer a l'IA
//     const format = (competences)=>{
//       const competence = formatCompetence(competences)
//      return `  peux-tu me faire une proposition de plan de carrière ou de certification a faire je suis ${profession.dataValues.profession} et je  souhaite devenir aussi expert dans: ${data.domaine} et je  possède déjà les compétences suivantes: ${competence}. je veux juste que tu te mette a la place d'un educateur et me donne la demarche a suivre pour avoir une expertise dans ${data.domaine} `
//      //Étant donné que je suis ${profession.dataValues.profession} et que j'aimerait évoluer dans: ${data.domaine}, en tenant compte de mes compétences suivantes : ${competence}, est-ce que tu peux me faire une proposition de plan de carrière ou une proposition de certification ?`
//   }
//    const resultat = format(competences)
//     // console.log(resultat)
  //  //communication avec l'IA

  //  const datas = async () => {
  //      try {
  //       const response = await axios.post(' https://generativelanguage.googleapis.com/v1/models/gemini-pro:generateContent?key= AIzaSyCJKdylpxbw14hTo86p4XFi4gjP-vTBxRs'
  //       , {
  //         "contents": [{
  //           "parts":[{
  //             "text": resultat
  //           }]}]}
        
  //        );
        
    
  //        return response;
  //     } catch (error) {
  //       console.error("Erreur lors de la requête:", error);
  //       throw error; // Vous pouvez gérer l'erreur ici ou la propager
  //      }
  //    };

  //    (async () => {
  //     try {
  //       const response = await datas();
  //       //console.log("Réponse de la requête:",  JSON.stringify(response.data.candidates[0].content.parts[0].text, null, 2));
  //       // const donnees = response.data.choices[0].message.content
       
  //      const  donnees =  response.data.candidates[0].content.parts[0].text
  //      socket.emit('planEvent',{donnees})
  //       // Faites ce que vous voulez avec la réponse ici
  //     } catch (error) {
  //       console.error("Erreur lors de l'utilisation de la fonction:", error);
  //     }
  //   })();
    
// })

// suggestion des competences

// socket.on('CompetenceSuggestionClientEvent',async (data)=>{
    
//   let user = await User.findOne({
//     where: { id:data.user},
//     include: [
//       {
//         model: db.Competence,
//         attributes: { exclude: ['userId'] },

//       },]})

//       const user_info= {competences} = user
//       // formatage du message pour envoyer a l'IA
//       const format = (competences)=>{
//         let dateActuelle = new Date();
//           const competence = formatCompetence(competences)
//          return `Étant donné un informaticien en : ${dateActuelle.getFullYear()}, qui possède les compétences suivantes : ${competence}, quelles autres compétences lui recommanderais-tu pour améliorer son expertise dans son domaine ,donne une reponse vraiment detailler ainsi que les lieu de formation? donne une justificaton pour chaque suggestion puis qu'il faut savoir pourquoi faire tel chose ou tel autre chose`
//       }
//      const resultat = format(competences)

//      //communication avec l'IA

//    const datas = async () => {
//     try {
//      const response = await axios.post(' https://generativelanguage.googleapis.com/v1/models/gemini-pro:generateContent?key= AIzaSyCJKdylpxbw14hTo86p4XFi4gjP-vTBxRs'
//      , {
//        "contents": [{
//          "parts":[{
//            "text": resultat
//          }]}]}
     
//       );
     
 
//       return response;
//    } catch (error) {
//      console.error("Erreur lors de la requête:", error);
//      throw error; // Vous pouvez gérer l'erreur ici ou la propager
//     }
//   };

//   (async () => {
//    try {
//      const response = await datas();
//      console.log("Réponse de la requête:",  JSON.stringify(response.data.candidates[0].content.parts[0].text, null, 2));
    
    
//     const  donnees =  response.data.candidates[0].content.parts[0].text
//     socket.emit('CompetenceSuggestionEvent',{donnees})
//      // Faites ce que vous voulez avec la réponse ici
//    } catch (error) {
//      console.error("Erreur lors de l'utilisation de la fonction:", error);
//    }
//  })();

// })

// generation d'un cv

socket.on('cvClientEvent', async(data)=>{
  let user = await User.findOne({
    where: { id:data.user },
    include: [
      {
        model: db.Certification,
        attributes: { exclude: ['userId'] },
      },
      {
        model: db.Competence,
        attributes: { exclude: ['userId'] },
      },
      {
        model:  db.Education,
        attributes: { exclude: ['userId'] },
      },
      {
        model: db.Experience,
        attributes: { exclude: ['userId'] },
      },
      {
        model: db.Info_perso,
        attributes: { exclude: ['userId'] },
      },
      {
        model:     db.Langue,
        attributes: { exclude: ['userId'] },
      },
     
      {
        model: db.Loisir,
        attributes: { exclude: ['userId'] },
      },
      {
        model: db.Resume,
        attributes: { exclude: ['userId'] },
      },
     
    ],
  });

  let user_final = {certifications,competences,education,experiences, info_persos, langues,loisirs,resumes} = user
   //console.log( JSON.stringify(info_persos.length()))
     console.log(info_persos[0].dataValues.nom)
  const formatage = (certifications,competences,education,experiences,langues,loisirs,resumes )=>{
     certificats = formatCertification(certifications)
     competences =  formatCompetence(competences)
     educations =  formatEducation(education) 
     experiences =  formatExperience(experiences)
     langues = formatLangues(langues)
     resume = formatResume(resumes)
     loisir = formatLoisir(loisirs)
    
   
     return ` en tenant compte de mes informations suivantes:Informations personnelles: nom=${info_persos[0].dataValues.nom},prenom=${info_persos[0].dataValues.prenom},profession=${info_persos[0].dataValues.profession},email=${info_persos[0].dataValues.email},adresse=${info_persos[0].dataValues.adresse} telephone=${user.dataValues.telephone}, ${resume},${educations},${certificats},${competences},${experiences},${langues},${loisir} produire moi un cv avec les differebtes section que je t'ai fournir.le cv  genere doit etre specifique au jod description suivant:${data.jobDescription} produire uniquement en focntion de mes information d'augmente rien rasur toi juste qu'il reponde au attentes de l'offre d'emploie a la fin fait des suggestion detailler et avec justification de competences a obtenir pour avoir plus de  chance d'etre retenu a cette offre d'emploi bien specifique je veux la reponse sous forme de json exploitable pour la section competence je veuxt juste un tableau d'element pas d'objet,pour les information personnel doivent toujours etre dans un objet appele:informations_personnelles et les langues parlées dans un tableau appele:langues , les proprietes du json doivent toujours etre en minuscul et en français ,met les suggestions doivent toujours etre  dans un tableau d'element  appele:suggestions, ne fait que des suggestion des competences que je n'ai pas `
  }
    
  resultat =  formatage(certifications,competences,education,experiences,langues,loisirs,resumes)
   console.log(resultat)
  // communication avec l'IA
  const datas = async () => {
    try {
     const response = await axios.post(' https://generativelanguage.googleapis.com/v1/models/gemini-pro:generateContent?key= AIzaSyCJKdylpxbw14hTo86p4XFi4gjP-vTBxRs'
     , {
       "contents": [{
         "parts":[{
           "text": resultat
         }]}]}
     
      );
     
 
      return response;
   } catch (error) {
     console.error("Erreur lors de la requête:", error);
     throw error; // Vous pouvez gérer l'erreur ici ou la propager
    }
  };

  (async () => {
   try {
     const response = await datas();
     console.log("Réponse de la requête:",  JSON.stringify(response.data, null, 2));
     const  donnees =  response.data.candidates[0].content.parts[0].text
  
 
    socket.emit('cvEvent',{donnees})
     // Faites ce que vous voulez avec la réponse ici
   } catch (error) {
     console.error("Erreur lors de l'utilisation de la fonction:", error);
   }
 })();
})


socket.on('clientEvent', function(data){

});
  console.log('A user connected');

  
  //Whenever someone disconnects this piece of code executed
  socket.on('disconnect', function () {
    // clients--;
    // socket.broadcast.emit('newclientconnect',{ description: clients + ' clients connected!'})
     console.log('A user disconnected');
  });
  
});

// fin communication socket.io



app.get('/', function(req, res){
  const filePath = path.resolve(__dirname, 'public', 'index.html');
  res.sendFile(filePath);
});


//*** lancement du serveur */

db.sequelize
  .authenticate()
  .then(() => {
    console.log("connexion a la BD  ok");
  })
  .then(() => {
    server.listen(port, () => {
      console.log(`server: http://localhost:${port}`);
    });
  })
  .catch((error) => {
    console.log("la connexion a la BD a echouee", error);
  });


  
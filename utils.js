
const db = require("./config/dbconfig")


let tableau;

// Formatage des compétences sous forme de chaîne de caractères
function formatCompetence(tableau) {
    let chaine = " j'ai les compétences suivante: "; 

    tableau.forEach(element => {
        chaine += `${element.nom_competence},`; 
    });

    return chaine;
}
// formatage des educations sous forme de chaine de carractere
 const formatEducation = (tableau)=>{
    let chaine = "education: "

    tableau.forEach(element => {
        chaine +=  `${element.diplome} en  ${element.date.getFullYear()},` 
        
    });
    return chaine

}

// formatage des experiences sous forme de chaine de carractere
const formatExperience = (tableau)=>{
   let chaine = "experience: "
   let employeur = ''
   tableau.forEach(element => {
     employeur +=` j'ai travaillé dans l'entreprise ${element.employeur} de ${element.date_debut.getFullYear()} à ${element.date_fin.getFullYear()} où j'occupais le poste de ${element.poste} `
    chaine +=  `${employeur},` 
    
});
return chaine
 }

 // formatage des informations personnels de l'utilisateur

 const formatLangues = (tableau)=>{
  let chaine = "Langues parlées: "
    
  tableau.forEach(element => {
    if(element.pourcentage >=50){
      
      chaine+= `${element.langue}-Courant,`
    }
    if(element.pourcentage<50){
     
      chaine+= `${element.langue}-Intermédiaire,`
             
    }

    
  })
  return chaine;
 }
 //formatage loisir
 const formatLoisir = (tableau)=>{
  let chaine = 'loisir:'
  tableau.forEach(element => {
    chaine+=`${element.nom_loisir},`
  })

  return chaine;

 }


// formatage des certifications sous forme de chaine de carractere
const formatCertification = (tableau)=>{
   let chaine = " j'ai les certifications suivante: " 
   if(Array.isArray(tableau) && tableau.length > 0){
    tableau.forEach(element => {
        chaine +=  `${element.intitule} obtenue en ${element.date.getFullYear()} ,` 
        
    });
       return chaine
   }
   return ''
}
// formatage final du resume de l'utilisateur
const formatage = (certifications,competences,education,experiences)=>{
    certificats = formatCertification(certifications)
     competences =  formatCompetence(competences)
     educations =  formatEducation(education) 
     experiences =  formatExperience(experiences)

     return ` a parti de mes information suivante es ce que tu peux fait une breve presentation de moi pour que je puise mettre dans mon cv:${educations} , ${competences},${experiences},${certificats} ` 

}
 
 
const formatResume = (tableau)=>{
  let chaine = 'Mon résumé: '
  tableau.forEach(element => {  
    chaine+=`${element.resume},`
  })
   return chaine
}

const formatPerso = (tableau) => {
  
  if (!Array.isArray(tableau) ) {
    console.log(ta)
    return `Informations personnelles: nom=${tableau.nom},prenom=${tableau.prenom},profession=${tableau.profession},email=${tableau.email},adresse=${tableau.adresse}`;
  }
  
  let chaine = 'Informations personnelles:';
  tableau.forEach(element => {  
    chaine += `nom=${element.nom},prenom=${element.prenom},profession=${element.profession},email=${element.email},adresse=${element.adresse}`;
  });
  return chaine;
}

module.exports = {
    formatCompetence,
    formatEducation,
    formatCertification,
    formatExperience,
    formatResume,
    formatLangues,
    formatLoisir,
    formatPerso,
}
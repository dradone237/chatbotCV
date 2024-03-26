const axios = require('axios');
const db = require("../config/dbconfig")
const Dialogue = db.Dialogue;
exports.generateCvPdf= async (req, res)=> {
  const pdfMonkeyUrl = 'https://api.pdfmonkey.io/api/v1/documents';

  // recuperation des elements envoyes

  const {
    question,reponse, date_reponse, date_question
  } = req.body;

  const configPot = {
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer GMgyLjRoYQbyBmPpoyku' 
    }
    

  };
  const configGet = {
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer GMgyLjRoYQbyBmPpoyku' 
      
    }
    
  };

 const datapdf = {
  "document": {
    "document_template_id": req.body.template_id,
    "status":"pending",
    "download_url": true,
    "payload": {
      ...req.body.data
    },
    "meta": {
      "clientId": "ABC1234-DE",
      "_filename": "document.pdf"
    },
   
    
  },
  

}
const meta = {
  "clientId": "ABC1234-DE",
  "_filename": "document.pdf",
  
}
 
if (!question || !reponse ||  !date_reponse|| !date_question) {
  return res
    .status(400)
    .json({ message: "rassuré vous d'avoir remplir tous les champs" });
}
//

// creation d'un document
const result = await axios.post(pdfMonkeyUrl, datapdf, configPot);
const ID = result.data.document.id;
//
// execution apres 2 secondes
setTimeout(async () => {
  try {
      // recuperation des informations sur le document
    const resultfinal = await axios.get(`https://api.pdfmonkey.io/api/v1/document_cards/${ID}`, configGet);
     // enregistrement des informations dans la table dialogue
    let dialogue = await Dialogue.create( {question:question,reponse:reponse,
      date_reponse:date_reponse,date_question:date_question,userId:req.id,links:resultfinal.data.document_card.download_url});
   
     
    return res.status(200).json({ message: "CV généré avec succès",url:resultfinal.data.document_card.download_url,data:dialogue});
  } catch (error) {
    if (error.name === "SequelizeDatabaseError") {
      return res.status(500).json({ message: "database error" ,error: error.message});
    }
    
    return res.status(500).json({message:"server error",error:error.message})
    
  }
}, 2000);


}

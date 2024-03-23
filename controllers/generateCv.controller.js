const axios = require('axios');
exports.generateCvPdf= async (req, res)=> {
  const pdfMonkeyUrl = 'https://api.pdfmonkey.io/api/v1/documents';

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
    "document_template_id": "42C06069-39A0-4FAE-B1A1-87DBCD7ADFEF",
    "status":"pending",
    "download_url": true,
    "payload": {
      ...req.body
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
// creation d'un document
const result = await axios.post(pdfMonkeyUrl, datapdf, configPot);
const ID = result.data.document.id;

// execution apres 2 secondes
setTimeout(async () => {
  try {
      // recuperation des informations sur le document
    const resultfinal = await axios.get(`https://api.pdfmonkey.io/api/v1/document_cards/${ID}`, configGet);
    console.log(resultfinal.data.document_card.download_url); 
     
    return res.status(200).json({ message: "CV généré avec succès",url:resultfinal.data.document_card.download_url});
  } catch (error) {
    console.error('Erreur lors de la requête GET :', error);
    return res.status(500).json({error:error.message})
    
  }
}, 2000);


}

//**generation de cv */

exports.generateCvPdf = (req, res) => {
  try {
    const PDFDocument = require("pdfkit");
    const fs = require("fs");
    const doc = new PDFDocument();
    doc.pipe(fs.createWriteStream("cv.pdf"));
    doc.text("Coding is Easy!");
    doc.moveDown();
    // Ajouter une ligne horizontale
    doc
      .lineCap("butt") // Définir le style de terminaison de la ligne
      .moveTo(100, 200) // Déplacer le point de départ de la ligne
      .lineTo(400, 200) // Dessiner une ligne jusqu'au point final
      .stroke(); // Tracer la ligne
    doc.text("Coding is Easy!", 100, 100);

    doc.end();

    return res.status(200).json({ message: "CV généré avec succès" });
  } catch (error) {
    return res.status(500).json({ error: error.name });
  }
};

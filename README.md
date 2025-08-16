from docx import Document
doc = Document()

# Title
doc.add_heading("Hospital Emergency Room Dashboard", level=1)

# Intro
doc.add_paragraph(
    "This project analyzes hospital emergency room data using Excel. "
    "The dataset contains around 480 patient records with details on admissions, wait times, satisfaction scores, and demographics. "
    "The goal of the project is to provide hospital management with actionable insights to improve patient care efficiency."
)

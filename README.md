from docx import Document

# Create a Word document
doc = Document()

# Title
doc.add_heading("Hospital Emergency Room Dashboard", level=1)

# Intro
doc.add_paragraph(
    "This project analyzes hospital emergency room data using Excel. "
    "The dataset contains around 480 patient records with details on admissions, wait times, satisfaction scores, and demographics. "
    "The goal of the project is to provide hospital management with actionable insights to improve patient care efficiency."
)

# Features section
doc.add_heading("🔑 Features", level=2)
features = [
    "Interactive Excel Dashboard with slicers & charts",
    "KPIs Tracked: Total patients & daily trends, Average waiting time, Patient satisfaction scores, Admission status & gender distribution",
    "Data cleaning & summarization using Pivot Tables",
    "Actionable insights for improving patient care and efficiency"
]
for f in features:
    doc.add_paragraph(f, style="List Bullet")

# Tools section
doc.add_heading("🛠️ Tools Used", level=2)
tools = ["Excel (Pivot Tables, Charts, Dashboarding)", "Hospital ER Dataset (CSV + Excel)"]
for t in tools:
    doc.add_paragraph(t, style="List Bullet")

# Add GitHub style note
doc.add_heading("📌 Usage in GitHub Repository", level=2)
doc.add_paragraph(
    "This description can be directly used in the README.md section of your GitHub repository. "
    "It provides a clear overview of the project, highlights key features, tools used, and conveys the purpose effectively."
)

# Save the file
output_path = "/mnt/data/Hospital_ER_Dashboard_ReadMe.docx"
doc.save(output_path)

output_path

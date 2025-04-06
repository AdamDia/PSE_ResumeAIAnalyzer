# 📄 Resume AI Analyzer – iOS App (SwiftUI)

**Resume AI Analyzer** is a mobile application that helps job seekers optimize their resumes by comparing them with job descriptions using on-device AI. It highlights missing keywords and provides instant feedback using Apple's Natural Language Processing (NLP) capabilities – all without any internet connection.

---

## ✨ Features

- Upload resume in **PDF** format
- Paste job descriptions manually
- AI-driven **keyword extraction** and **matching**
- Highlights **missing keywords**
- **Offline support** – all data stays on the device
- Store and manage previously uploaded resumes
- Swipe-to-delete functionality with animation
- Domain selection for smarter suggestions (e.g. iOS, Data, Design)

---

## 🧠 Architecture

The app follows a **modular MVVM architecture**, with clean separation of views, logic, and storage:

- `HomeView.swift`: Resume uploads, job description input, navigation
- `UploadResumeView.swift`: PDF parsing via PDFKit
- `ResumeResultView.swift`: Keyword matching and result display
- `KeywordAnalyzer.swift`: NLP-based analysis using `NaturalLanguage`
- `StorageManager.swift`: Resume data persistence using `UserDefaults`

---

## 🛠 Frameworks & Tools

| Tool / Framework       | Purpose                                      |
|------------------------|----------------------------------------------|
| [SwiftUI](https://developer.apple.com/xcode/swiftui/) | Declarative UI for modern iOS apps |
| [NaturalLanguage](https://developer.apple.com/documentation/naturallanguage/) | On-device NLP keyword extraction |
| [PDFKit](https://developer.apple.com/documentation/pdfkit/) | Secure PDF parsing |
| [UserDefaults](https://developer.apple.com/documentation/foundation/userdefaults) | Lightweight offline storage |

> 📌 Future versions may consider using **CoreML**, **CoreData**, or **CloudKit** for expanded capabilities.

---

## ✅ Testing Strategy

The app was manually tested across common and edge scenarios:

- Resume parsing with various formats
- Keyword extraction and matching
- Navigation between views
- Offline functionality and resume persistence
- Alert handling for empty inputs or invalid files

Tested using:
- Xcode Simulator (iPhone 15, iPhone SE)
- SwiftUI Previews

---

## 📦 Installation

1. Clone the repository  
   ```bash
   git clone https://github.com/AdamDia/PSE_ResumeAIAnalyzer.git
2. Open ResumeAIAnalyzer.xcodeproj in Xcode

3. Build and run on iOS Simulator or physical device

//
//  UploadResumeView.swift
//  ResumeAIAnalyzer
//
//  Created by Adam Essam on 24/03/2025.
//

import Foundation
import UniformTypeIdentifiers
import PDFKit
import SwiftUI

struct UploadResumeView: UIViewControllerRepresentable {
    @Binding var resumeText: String

     func makeCoordinator() -> Coordinator {
         Coordinator(self)
     }

     func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
         let picker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.pdf])
         picker.delegate = context.coordinator
         return picker
     }

     func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}

     class Coordinator: NSObject, UIDocumentPickerDelegate {
         var parent: UploadResumeView

         init(_ parent: UploadResumeView) {
             self.parent = parent
         }

         func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
             guard let url = urls.first else { return }
             parent.resumeText = ResumeParser.extractText(from: url)
         }
     }
}

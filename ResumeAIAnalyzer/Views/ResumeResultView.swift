//
//  ResumeResultView.swift
//  ResumeAIAnalyzer
//
//  Created by Adam Essam on 24/03/2025.
//

import SwiftUI

struct ResumeResultView: View {
    
    let resumeText: String
    let jobDescription: String
    let domain: String
    
     var keywordSuggestions: [String] {
         KeywordAnalyzer.missingKeywords(from: jobDescription, in: resumeText, domain: domain)
     }

     var missingSections: [String] {
         ATSFeedbackService.missingSections(in: resumeText)
     }

     var body: some View {
         ScrollView {
             VStack(alignment: .leading, spacing: 16) {
                 Text("Resume Content")
                     .font(.headline)
                 Text(resumeText)
                     .font(.body)
                     .padding()
                     .background(Color(.secondarySystemBackground))
                     .cornerRadius(10)

                 Divider()

                 Text("Keyword Suggestions")
                     .font(.headline)
                 if keywordSuggestions.isEmpty {
                     Text("Great! Your resume covers key terms.")
                 } else {
                     ForEach(keywordSuggestions, id: \.self) { keyword in
                         Text("- Add: \(keyword)")
                     }
                 }

                 Divider()

                 Text("ATS Section Feedback")
                     .font(.headline)
                 if missingSections.isEmpty {
                     Text("All standard sections found.")
                 } else {
                     ForEach(missingSections, id: \.self) { section in
                         Text("- Consider adding: \(section)")
                     }
                 }
             }
             .padding()
         }
         .navigationTitle("Analysis Result")
     }
}

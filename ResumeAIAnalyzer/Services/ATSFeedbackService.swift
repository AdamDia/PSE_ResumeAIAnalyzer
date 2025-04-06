//
//  ATSFeedbackService.swift
//  ResumeAIAnalyzer
//
//  Created by Adam Essam on 24/03/2025.
//

// Services/ATSFeedbackService.swift
struct ATSFeedbackService {
    static let requiredSections = ["Experience", "Education", "Skills", "Projects"]

    static func missingSections(in text: String) -> [String] {
        return requiredSections.filter { !text.localizedCaseInsensitiveContains($0) }
    }
}

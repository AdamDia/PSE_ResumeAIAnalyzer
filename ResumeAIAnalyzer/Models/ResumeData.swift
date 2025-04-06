//
//  ResumeData.swift
//  ResumeAIAnalyzer
//
//  Created by Adam Essam on 24/03/2025.
//

import Foundation

struct ResumeData: Identifiable, Codable, Equatable, Hashable {
    let id: UUID
    let content: String
    let date: Date
    let domain: String
    let jobDescription: String

    init(content: String, domain: String, jobDescription: String) {
        self.id = UUID()
        self.content = content
        self.date = Date()
        self.domain = domain
        self.jobDescription = jobDescription
    }
}

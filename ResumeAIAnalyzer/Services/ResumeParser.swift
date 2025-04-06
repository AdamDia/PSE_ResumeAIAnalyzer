//
//  ResumeParser.swift
//  ResumeAIAnalyzer
//
//  Created by Adam Essam on 24/03/2025.
//

import PDFKit

struct ResumeParser {
    static func extractText(from url: URL) -> String {
        guard let pdf = PDFDocument(url: url) else { return "" }
        var content = ""
        for i in 0..<pdf.pageCount {
            if let page = pdf.page(at: i) {
                content += page.string ?? ""
            }
        }
        return content
    }
}

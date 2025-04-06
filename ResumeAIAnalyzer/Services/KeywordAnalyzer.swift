//
//  KeywordAnalyzer.swift
//  ResumeAIAnalyzer
//
//  Created by Adam Essam on 24/03/2025.
//

import NaturalLanguage

struct KeywordAnalyzer {

    static let stopWords: Set<String> = [
        "should", "have", "will", "work", "high", "strong", "ideal", "lead", "looking",
        "closely", "deliver", "development", "design", "engineers", "candidates", "managers",
        "data", "and", "with", "that", "this", "from", "into", "for", "the", "you", "your", "are",
        "was", "were", "been", "being", "about", "able", "they", "them", "our", "their", "more",
        "than", "some", "most", "such", "just", "any", "each", "few", "who", "whom", "whose",
        "which", "what", "when", "where", "why", "how"
    ]

    static let techTerms: [String: Set<String>] = [
        "general": [
            "project management", "agile", "scrum", "team leadership", "stakeholder communication"
        ],
        "ios": [
            "swift", "swiftui", "xcode", "cocoapods", "firebase", "app store", "ui kit", "mvvm", "combine"
        ],
        "data": [
            "machine learning", "python", "pandas", "sql", "data pipeline", "jupyter", "regression"
        ],
        "design": [
            "figma", "adobe xd", "sketch", "ui/ux", "wireframe", "prototyping"
        ]
    ]

    static func extractKeywords(from text: String) -> [String] {
        let tagger = NLTagger(tagSchemes: [.nameType, .lexicalClass])
        tagger.string = text

        var phrases = Set<String>()
        let options: NLTagger.Options = [.omitPunctuation, .omitWhitespace, .joinNames]

        tagger.enumerateTags(in: text.startIndex..<text.endIndex, unit: .word, scheme: .lexicalClass, options: options) { tag, tokenRange in
            if let tag = tag, [.noun, .verb, .adjective].contains(tag) {
                let word = String(text[tokenRange]).lowercased()
                if word.count > 3 && !stopWords.contains(word) {
                    phrases.insert(word)
                }
            }
            return true
        }

        let words = text
            .components(separatedBy: CharacterSet.alphanumerics.inverted)
            .map { $0.lowercased() }
            .filter { $0.count > 3 && !stopWords.contains($0) }

        if words.count >= 2 {
            for i in 0..<(words.count - 1) {
                let bigram = "\(words[i]) \(words[i+1])"
                if !containsOnlyStopwords(bigram) { phrases.insert(bigram) }

                if i < words.count - 2 {
                    let trigram = "\(words[i]) \(words[i+1]) \(words[i+2])"
                    if !containsOnlyStopwords(trigram) { phrases.insert(trigram) }
                }
            }
        }


        let final = Array(phrases).sorted { $0.count > $1.count }
        let filtered = final.filter { phrase in
            isUsefulPhrase(phrase) && !final.contains { longer in
                longer != phrase && longer.contains(phrase)
            }
        }

        return filtered
    }

    private static func containsOnlyStopwords(_ phrase: String) -> Bool {
        return phrase
            .split(separator: " ")
            .allSatisfy { stopWords.contains($0.lowercased()) }
    }

    private static func isUsefulPhrase(_ phrase: String) -> Bool {
        let contentWords = phrase
            .split(separator: " ")
            .filter { !stopWords.contains($0.lowercased()) }
        return contentWords.count >= 2
    }

    static func missingKeywords(from jobDescription: String, in resume: String, domain: String = "general") -> [String] {
        let jobKeywords = extractKeywords(from: jobDescription)
        let resumeLower = resume.lowercased()
        let domainTerms = techTerms[domain, default: []]

        let scoredKeywords = jobKeywords.map { keyword -> (String, Int) in
            let baseScore = keyword.split(separator: " ").count * 2
            let boost = domainTerms.contains(keyword) ? 5 : 0
            return (keyword, baseScore + boost)
        }

        let missing = scoredKeywords
            .filter { keyword, _ in !resumeLower.localizedStandardContains(keyword) }
            .sorted { $0.1 > $1.1 }
            .map { $0.0 }

        return Array(missing.prefix(10))
    }
}



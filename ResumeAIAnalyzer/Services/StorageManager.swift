//
//  StorageManager.swift
//  ResumeAIAnalyzer
//
//  Created by Adam Essam on 24/03/2025.
//

import Foundation

struct StorageManager {
    static let key = "SavedResumes"

    static func load() -> [ResumeData] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        return (try? JSONDecoder().decode([ResumeData].self, from: data)) ?? []
    }

    static func save(_ resume: ResumeData) {
        var current = load()
        current.append(resume)
        saveAll(current)
    }

    static func delete(_ resume: ResumeData) {
        var current = load()
        current.removeAll { $0.id == resume.id }
        saveAll(current)
    }

    private static func saveAll(_ resumes: [ResumeData]) {
        if let data = try? JSONEncoder().encode(resumes) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}

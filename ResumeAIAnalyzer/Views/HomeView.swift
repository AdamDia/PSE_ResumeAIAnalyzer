//
//  HomeView.swift
//  ResumeAIAnalyzer
//
//  Created by Adam Essam on 24/03/2025.
//

import SwiftUI

struct HomeView: View {

    @State private var showingPicker = false
    @State private var resumeText: String = ""
    @State private var savedResumes: [ResumeData] = []
    @State private var jobDescription: String = ""
    @State private var showJobAlert = false
    @State private var selectedDomain: String = "general"
    @State private var path = NavigationPath()
//    @State private var selectedResume: ResumeData.ID?


    private let domains = ["general", "ios", "data", "design"]

    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 20) {
                Text("Resume AI Analyzer")
                    .font(.largeTitle)
                    .bold()

                Button("Upload Resume (PDF)") {
                    showingPicker = true
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)

                Text("Select Domain")
                    .font(.headline)
                Picker("Domain", selection: $selectedDomain) {
                    ForEach(domains, id: \.self) { domain in
                        Text(domain.capitalized).tag(domain)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())

                Text("Paste Job Description")
                    .font(.headline)
                TextEditor(text: $jobDescription)
                    .frame(height: 150)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5)))
        

                if !resumeText.isEmpty {
                    Button("View Analysis") {
                        if jobDescription.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            showJobAlert = true
                        } else {
                            let newResume = ResumeData(content: resumeText, domain: selectedDomain, jobDescription: jobDescription)
                            StorageManager.save(newResume)
                            savedResumes.append(newResume)
                            path.append(newResume)
                            resumeText = ""
                        }
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }

                if !savedResumes.isEmpty {
                    List {
                        ForEach(savedResumes) { resume in
                            NavigationLink(value: resume) {
                                VStack(alignment: .leading) {
                                    Text(String(resume.content.prefix(60)) + "...")
                                        .lineLimit(1)
                                    Text(resume.date.formatted())
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    savedResumes = StorageManager.load() // reload and trigger visual refresh
                                }
                            })
                            .swipeActions {
                                Button(role: .destructive) {
                                    withAnimation {
                                        StorageManager.delete(resume)
                                        savedResumes.removeAll { $0.id == resume.id }
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                    .id(savedResumes.count)
                }
            }
            .padding()
            .navigationTitle("Home")
            .sheet(isPresented: $showingPicker) {
                UploadResumeView(resumeText: $resumeText)
            }
            .alert("Job Description Required", isPresented: $showJobAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Please paste a job description before viewing the analysis.")
            }
            .navigationDestination(for: ResumeData.self) { resume in
                ResumeResultView(resumeText: resume.content, jobDescription: resume.jobDescription, domain: resume.domain)
            }
        }
        .onAppear {
            savedResumes = StorageManager.load()
//            selectedResume = nil
        }
    }
}

#Preview {
    HomeView()
}




// SettingsView.swift
import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var languageSettings: LanguageSettings
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    
    var body: some View {
        Form {
            // Phần chọn ngôn ngữ
            Section(header: Text("language".localised(using: languageSettings.selectedLanguage))) {
                NavigationLink(destination: LanguageSelectionView()) {
                    HStack {
                        Text("select_language".localised(using: languageSettings.selectedLanguage))
                        Spacer()
                        if let language = Language.supportedLanguages.first(where: { $0.code == languageSettings.selectedLanguage }) {
                            HStack {
                                Text(language.flag)
                                Text(language.name)
                            }
                            .foregroundColor(.gray)
                        }
                    }
                }
            }
            
            // Phần chọn giao diện (sáng/tối)
            Section(header: Text("appearance".localised(using: languageSettings.selectedLanguage))) {
                Toggle(isOn: $isDarkMode) {
                    Text("dark_mode".localised(using: languageSettings.selectedLanguage))
                }
            }
        }
        .navigationTitle("settings".localised(using: languageSettings.selectedLanguage))
    }
}

// LanguageSelectionView.swift
import SwiftUI

struct LanguageSelectionView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var languageSettings: LanguageSettings
    @State private var searchText: String = ""
    
    var filteredLanguages: [Language] {
        if searchText.isEmpty {
            return Language.supportedLanguages
        } else {
            return Language.supportedLanguages.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        List {
            ForEach(filteredLanguages) { language in
                Button(action: {
                    languageSettings.setLanguage(language.code)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Text(language.flag)
                        Text(language.name)
                        Spacer()
                        if language.code == languageSettings.selectedLanguage {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: NSLocalizedString("search_language", comment: ""))
        .navigationTitle("select_language".localised(using: languageSettings.selectedLanguage))
    }
}
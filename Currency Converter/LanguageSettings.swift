// import Foundation

// class LanguageSettings: ObservableObject {
//     @Published var selectedLanguage: String  {
//         didSet {
//             UserDefaults.standard.set([selectedLanguage], forKey: "selectedLanguage")
//             UserDefaults.standard.synchronize()
//         }
//     }
    
//     init() {
//         self.selectedLanguage = UserDefaults.standard.string(forKey: "selectedLanguage") ?? Locale.current.language.languageCode?.identifier ?? "vi"
//     }

//     func setLanguage(_ languageCode: String) {
//         if Bundle.main.localizations.contains(languageCode) {
//             UserDefaults.standard.set([selectedLanguage], forKey: "selectedLanguage")
//             selectedLanguage = languageCode
//         }
//     }
// }


import Foundation

class LanguageSettings: ObservableObject {
    static let shared = LanguageSettings()
    @Published var selectedLanguage = Locale.current.language.languageCode?.identifier ?? "en"

    func setLanguage(_ languageCode: String) {
        if Bundle.main.localizations.contains(languageCode) {
            UserDefaults.standard.set([languageCode], forKey: "MyLanguages")
            selectedLanguage = languageCode
        }
    }

    var supportedLanguages: [String] {
        return ["en", "vi"]
    }

    func languageDisplayName(for languageCode: String) -> String {
        switch languageCode {
        case "en":
            return "English"
        case "vi":
            return "Viewnamese"
        default:
            return ""
        }
    }
}

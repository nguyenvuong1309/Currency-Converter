//
//  Currency_ConverterApp.swift
//  Currency Converter
//
//  Created by ducvuong on 27/10/24.
//

import SwiftUI

@main
struct CurrencyConverterApp: App {
    @StateObject var languageSettings = LanguageSettings()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(languageSettings)
                // .environment(\.locale, .init(identifier: languageSettings.selectedLanguage))
        }
    }
}

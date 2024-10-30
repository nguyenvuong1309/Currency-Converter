# Currency Converter Application

## Introduction

**Currency Converter** is a mobile application developed using Swift and SwiftUI, providing the ability to convert various currencies. The application also supports multiple languages (English and Vietnamese) and allows switching between light and dark themes. I have also written a GitHub Action that translates the Vietnamese Localizable.strings file into English (details in the [Some Issues](#some-issues) section).

Link video demo:

- Demo app:

[![Demo app](https://img.youtube.com/vi/QODzVXzPn5I/0.jpg)](https://www.youtube.com/watch?v=QODzVXzPn5I)

- Demo unit test:

[![Demo unit test](https://img.youtube.com/vi/dl2GjIBKhAU/0.jpg)](https://www.youtube.com/watch?v=dl2GjIBKhAU)

- Demo workflow auto translate:

[![Demo workflow auto translate](https://img.youtube.com/vi/rFARYuXv3iA/0.jpg)](https://www.youtube.com/watch?v=rFARYuXv3iA)

## Main Features

- **Currency Conversion**.
- **Multi-Language Support**.
- **Dark/Light Mode Interface**.

## Project Structure

- In this project, I use the MVVM (Model-View-ViewModel) pattern to make the code easily reusable and maintainable.

### Description of Main Folders

- **Core**: Includes basic classes like `BaseViewModel` and `HTTPClient` for handling network requests.

- **Extensions**: Extensions for standard classes like `Color` and `String` to add additional functionalities.

- **Model**: Defines the data models used in the application such as `Language` and `ExchangeRatesResponse`.

- **Service**: Contains protocols and service implementations to interact with external APIs.

- **Screen**: Includes the main screens of the application like `ConverterScreen`, `LanguageSelectionScreen`, and `SettingScreen`, along with their corresponding Views and ViewModels.

- **Components**: Reusable UI components such as `CurrencyPicker` and `CustomStateView`.

## Technologies Used

- **Swift**: The primary programming language used for developing the application.
- **SwiftUI**: Apple's modern UI framework for building user interfaces.
- **Combine**: Apple's framework for handling asynchronous events and connecting to data sources.
- **@StateObject & @EnvironmentObject**: SwiftUI property wrappers for managing state and sharing data between views.
- **@AppStorage**: Used to store settings such as dark/light mode and selected language.
- **Deep Translator (GoogleTranslator)**: This library is used to support content translation within the application.
- **URLSession & DataTaskPublisher**: To perform network requests and fetch exchange rate data from the API.
- **Localizable.strings**: Supports multiple languages, ensuring the application can be easily used by users in various countries.

## Installation

1. **Requirements**:

   - Xcode 12 or later
   - iOS 14 or later

2. **Installation**:
   - Clone repository:
     ```bash
     git clone https://github.com/username/Currency-Converter.git
     ```
   - Open project in Xcode:
     ```bash
     cd Currency-Converter
     open Currency-Converter.xcodeproj
     ```
   - Choose a simulator or connect a real device and press `Run`.

## Some Issues

- In this project, I support multiple languages using Localizable.strings, but a problem arises: defining such for all language files of all countries would take a lot of time and effort. My idea here is to write a Python program that can translate the Vietnamese file into all other languages. This Python file will be executed by GitHub Actions. Each time someone creates a pull request, the workflow will run. The changes will be generated and committed to that pull request by github-actions[bot]. Due to limited time, I have only managed to translate from Vietnamese to English.

![image](https://github.com/user-attachments/assets/4bb1e643-5780-4c15-8f1e-5f4984badf1c)

## Contact

- Email: [nguyenducvuong13092003@gmail.com](mailto:nguyenducvuong13092003@gmail.com)
- Phone: 0914595627
- LinkedIn: [vuong-nguyen-duc](https://www.linkedin.com/in/v%C6%B0%C6%A1ng-nguy%E1%BB%85n-%C4%91%E1%BB%A9c-77aa2824a/)

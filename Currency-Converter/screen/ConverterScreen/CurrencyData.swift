let currencies = ["AED", "AFN", "ALL", "AMD", "ANG", "AOA", "ARS", "AUD", "AWG", "AZN", "BAM", "BBD", 
    "BDT", "BGN", "BHD", "BIF", "BMD", "BND", "BOB", "BRL", "BSD", "BTC", "BTN", "BWP", "BYN", "BYR", "BZD", "CAD", 
    "CDF", "CHF", "CLF", "CLP", "CNY", "CNH", "COP", "CRC", "CUC", "CUP", "CVE", "CZK", "DJF", "DKK", "DOP", "DZD", 
    "EGP", "ERN", "ETB", "EUR", "FJD", "FKP", "GBP", "GEL", "GGP", "GHS", "GIP", "GMD", "GNF", "GTQ", "GYD", "HKD", 
    "HNL", "HRK", "HTG", "HUF", "IDR", "ILS", "IMP", "INR", "IQD", "IRR", "ISK", "JEP", "JMD", "JOD", "JPY", "KES", 
    "KGS", "KHR", "KMF", "KPW", "KRW", "KWD", "KYD", "KZT", "LAK", "LBP", "LKR", "LRD", "LSL", "LTL", "LVL", "LYD", 
    "MAD", "MDL", "MGA", "MKD", "MMK", "MNT", "MOP", "MRU", "MUR", "MVR", "MWK", "MXN", "MYR", "MZN", "NAD", "NGN", 
    "NIO", "NOK", "NPR", "NZD", "OMR", "PAB", "PEN", "PGK", "PHP", "PKR", "PLN", "PYG", "QAR", "RON", "RSD", "RUB", 
    "RWF", "SAR", "SBD", "SCR", "SDG", "SEK", "SGD", "SHP", "SLE", "SLL", "SOS", "SRD", "STD", "SVC", "SYP", "SZL", 
    "THB", "TJS", "TMT", "TND", "TOP", "TRY", "TTD", "TWD", "TZS", "UAH", "UGX", "USD", "UYU", "UZS", "VEF", "VES", 
    "VND", "VUV", "WST", "XAF", "XAG", "XAU", "XCD", "XDR", "XOF", "XPF", "YER", "ZAR", "ZMK", "ZMW", "ZWL"]

let currencyFlags: [String: String] = [
    "AED": "🇦🇪", // United Arab Emirates
    "AFN": "🇦🇫", // Afghanistan
    "ALL": "🇦🇱", // Albania
    "AMD": "🇦🇲", // Armenia
    "ANG": "🇳🇱", // Curaçao & Sint Maarten (Netherlands)
    "AOA": "🇦🇴", // Angola
    "ARS": "🇦🇷", // Argentina
    "AUD": "🇦🇺", // Australia
    "AWG": "🇦🇼", // Aruba
    "AZN": "🇦🇿", // Azerbaijan
    "BAM": "🇧🇦", // Bosnia & Herzegovina
    "BBD": "🇧🇧", // Barbados
    "BDT": "🇧🇩", // Bangladesh
    "BGN": "🇧🇬", // Bulgaria
    "BHD": "🇧🇭", // Bahrain
    "BIF": "🇧🇮", // Burundi
    "BMD": "🇧🇲", // Bermuda
    "BND": "🇧🇳", // Brunei
    "BOB": "🇧🇴", // Bolivia
    "BRL": "🇧🇷", // Brazil
    "BSD": "🇧🇸", // Bahamas
    "BTC": "🟡",   // Bitcoin (No specific flag)
    "BTN": "🇧🇹", // Bhutan
    "BWP": "🇧🇼", // Botswana
    "BYN": "🇧🇾", // Belarus
    "BYR": "🇧🇾", // Belarus (Old)
    "BZD": "🇧🇿", // Belize
    "CAD": "🇨🇦", // Canada
    "CDF": "🇨🇩", // Democratic Republic of the Congo
    "CHF": "🇨🇭", // Switzerland
    "CLF": "🇨🇱", // Chile (Unidad de Fomento)
    "CLP": "🇨🇱", // Chile
    "CNY": "🇨🇳", // China
    "CNH": "🇨🇳", // China (Offshore)
    "COP": "🇨🇴", // Colombia
    "CRC": "🇨🇷", // Costa Rica
    "CUC": "🇨🇺", // Cuba (Convertible Peso)
    "CUP": "🇨🇺", // Cuba
    "CVE": "🇨🇻", // Cape Verde
    "CZK": "🇨🇿", // Czech Republic
    "DJF": "🇩🇯", // Djibouti
    "DKK": "🇩🇰", // Denmark
    "DOP": "🇩🇴", // Dominican Republic
    "DZD": "🇩🇿", // Algeria
    "EGP": "🇪🇬", // Egypt
    "ERN": "🇪🇷", // Eritrea
    "ETB": "🇪🇹", // Ethiopia
    "EUR": "🇪🇺", // Eurozone
    "FJD": "🇫🇯", // Fiji
    "FKP": "🇫🇰", // Falkland Islands
    "GBP": "🇬🇧", // United Kingdom
    "GEL": "🇬🇪", // Georgia
    "GGP": "🇬🇬", // Guernsey
    "GHS": "🇬🇭", // Ghana
    "GIP": "🇬🇮", // Gibraltar
    "GMD": "🇬🇲", // Gambia
    "GNF": "🇬🇳", // Guinea
    "GTQ": "🇬🇹", // Guatemala
    "GYD": "🇬🇾", // Guyana
    "HKD": "🇭🇰", // Hong Kong
    "HNL": "🇭🇳", // Honduras
    "HRK": "🇭🇷", // Croatia
    "HTG": "🇭🇹", // Haiti
    "HUF": "🇭🇺", // Hungary
    "IDR": "🇮🇩", // Indonesia
    "ILS": "🇮🇱", // Israel
    "IMP": "🇮🇲", // Isle of Man
    "INR": "🇮🇳", // India
    "IQD": "🇮🇶", // Iraq
    "IRR": "🇮🇷", // Iran
    "ISK": "🇮🇸", // Iceland
    "JEP": "🇯🇪", // Jersey
    "JMD": "🇯🇲", // Jamaica
    "JOD": "🇯🇴", // Jordan
    "JPY": "🇯🇵", // Japan
    "KES": "🇰🇪", // Kenya
    "KGS": "🇰🇬", // Kyrgyzstan
    "KHR": "🇰🇭", // Cambodia
    "KMF": "🇰🇲", // Comoros
    "KPW": "🇰🇵", // North Korea
    "KRW": "🇰🇷", // South Korea
    "KWD": "🇰🇼", // Kuwait
    "KYD": "🇰🇾", // Cayman Islands
    "KZT": "🇰🇿", // Kazakhstan
    "LAK": "🇱🇦", // Laos
    "LBP": "🇱🇧", // Lebanon
    "LKR": "🇱🇰", // Sri Lanka
    "LRD": "🇱🇷", // Liberia
    "LSL": "🇱🇸", // Lesotho
    "LTL": "🇱🇹", // Lithuania (Old)
    "LVL": "🇱🇻", // Latvia (Old)
    "LYD": "🇱🇾", // Libya
    "MAD": "🇲🇦", // Morocco
    "MDL": "🇲🇩", // Moldova
    "MGA": "🇲🇬", // Madagascar
    "MKD": "🇲🇰", // North Macedonia
    "MMK": "🇲🇲", // Myanmar
    "MNT": "🇲🇳", // Mongolia
    "MOP": "🇲🇴", // Macau
    "MRU": "🇲🇷", // Mauritania
    "MUR": "🇲🇺", // Mauritius
    "MVR": "🇲🇻", // Maldives
    "MWK": "🇲🇼", // Malawi
    "MXN": "🇲🇽", // Mexico
    "MYR": "🇲🇾", // Malaysia
    "MZN": "🇲🇿", // Mozambique
    "NAD": "🇳🇦", // Namibia
    "NGN": "🇳🇬", // Nigeria
    "NIO": "🇳🇮", // Nicaragua
    "NOK": "🇳🇴", // Norway
    "NPR": "🇳🇵", // Nepal
    "NZD": "🇳🇿", // New Zealand
    "OMR": "🇴🇲", // Oman
    "PAB": "🇵🇦", // Panama
    "PEN": "🇵🇪", // Peru
    "PGK": "🇵🇬", // Papua New Guinea
    "PHP": "🇵🇭", // Philippines
    "PKR": "🇵🇰", // Pakistan
    "PLN": "🇵🇱", // Poland
    "PYG": "🇵🇾", // Paraguay
    "QAR": "🇶🇦", // Qatar
    "RON": "🇷🇴", // Romania
    "RSD": "🇷🇸", // Serbia
    "RUB": "🇷🇺", // Russia
    "RWF": "🇷🇼", // Rwanda
    "SAR": "🇸🇦", // Saudi Arabia
    "SBD": "🇸🇧", // Solomon Islands
    "SCR": "🇸🇨", // Seychelles
    "SDG": "🇸🇩", // Sudan
    "SEK": "🇸🇪", // Sweden
    "SGD": "🇸🇬", // Singapore
    "SHP": "🇸🇭", // Saint Helena
    "SLE": "🇸🇱", // Sierra Leone
    "SLL": "🇸🇱", // Sierra Leone (Old)
    "SOS": "🇸🇴", // Somalia
    "SRD": "🇸🇷", // Suriname
    "STD": "🇸🇹", // São Tomé & Príncipe (Old)
    "SVC": "🇸🇻", // El Salvador
    "SYP": "🇸🇾", // Syria
    "SZL": "🇸🇿", // Eswatini
    "THB": "🇹🇭", // Thailand
    "TJS": "🇹🇯", // Tajikistan
    "TMT": "🇹🇲", // Turkmenistan
    "TND": "🇹🇳", // Tunisia
    "TOP": "🇹🇴", // Tonga
    "TRY": "🇹🇷", // Turkey
    "TTD": "🇹🇹", // Trinidad & Tobago
    "TWD": "🇹🇼", // Taiwan
    "TZS": "🇹🇿", // Tanzania
    "UAH": "🇺🇦", // Ukraine
    "UGX": "🇺🇬", // Uganda
    "USD": "🇺🇸", // United States
    "UYU": "🇺🇾", // Uruguay
    "UZS": "🇺🇿", // Uzbekistan
    "VEF": "🇻🇪", // Venezuela (Old)
    "VES": "🇻🇪", // Venezuela
    "VND": "🇻🇳", // Vietnam
    "VUV": "🇻🇺", // Vanuatu
    "WST": "🇼🇸", // Samoa
    "XAF": "🌍", // Central African CFA Franc (No specific emoji)
    "XAG": "🟡", // Silver (Commodity)
    "XAU": "🟡", // Gold (Commodity)
    "XCD": "🇨🇩", // East Caribbean Dollar (Caribbean nations)
    "XDR": "🌐", // Special Drawing Rights (No emoji)
    "XOF": "🌍", // West African CFA Franc (No specific emoji)
    "XPF": "🌐", // CFP Franc (No specific emoji)
    "YER": "🇾🇪", // Yemen
    "ZAR": "🇿🇦", // South Africa
    "ZMK": "🇿🇲", // Zambia (Old)
    "ZMW": "🇿🇲", // Zambia
    "ZWL": "🇿🇼", // Zimbabwe
]
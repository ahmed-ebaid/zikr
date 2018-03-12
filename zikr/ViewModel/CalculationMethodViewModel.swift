import Foundation

class CalculationMethodViewModel {
    lazy var calculationMethods = [("Jafari - Ithna Ashari." , 0),
                              ("Karachi - University of Islamic Sciences.", 1),
                              ("ISNA - Islamic Society of North America.", 2),
                              ("MWL - Muslim World League." , 3),
                              ("Mecca - Umm al-Qura.", 4),
                              ("Egyptian General Authority of Survey.", 5),
                              ("University of Tehran - Institute of Geophysics.", 7),
                              ("Algerian Minister of Religious Affairs and Wakfs." , 8),
                              ("Gulf 90 Minutes Fixed Isha.", 9),
                              ("Egyptian General Authority of Survey (Bis).", 10),
                              ("UOIF - Union Des Organisations Islamiques De France.", 11),
                              ("Sistem Informasi Hisab Rukyat Indonesia.", 12),
                              ("Diyanet İşleri Başkanlığı.", 13),
                              ("Germany Custom.", 14),
                              ("Russia Custom.", 15)
                              ]
    var userDefaults: UserDefaults!
    
    init() {
        userDefaults = UserDefaults.standard
    }
    
    func setDefaultCalculationMethod(calculationMethod: String = "ISNA - Islamic Society of North America.") {
        
    }
}

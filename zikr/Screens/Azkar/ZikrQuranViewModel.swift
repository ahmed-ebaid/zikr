import Foundation

class ZikrQuranViewModel {
    var zikrModels: [ZikrModel]!
    
    init() {
        zikrModels = []
        configureAzkar()
    }
    
    func configureAzkar() {
        zikrModels.append(ZikrModel(title: "أَعُوذُ بِاللهِ مِنْ الشَّيْطَانِ الرَّجِيمِ", zikr: "اللّهُ لاَ إِلَهَ إِلاَّ هُوَ الْحَيُّ الْقَيُّومُ لاَ تَأْخُذُهُ سِنَةٌ وَلاَ نَوْمٌ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلاَّ بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلاَ يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلاَّ بِمَا شَاء وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالأَرْضَ وَلاَ يَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُ", fadl: "من قالها حين يصبح أجير من الجن حتى يمسى ومن قالها حين يمسى أجير من الجن حتى يصبح", numberOfTimes: "مرة واحدة"))
        
        zikrModels.append(ZikrModel(title: "بِسْمِ اللهِ الرَّحْمنِ الرَّحِيم", zikr: "قُلْ هُوَ اللَّهُ أَحَدٌ، اللَّهُ الصَّمَدُ، لَمْ يَلِدْ وَلَمْ يُولَدْ، وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ", fadl: "من قالهما حين يصبح وحين يمسى كفته من كل شيء", numberOfTimes: "ثلاث مرات"))
        
        zikrModels.append(ZikrModel(title: "بِسْمِ اللهِ الرَّحْمنِ الرَّحِيم", zikr: "قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ، مِن شَرِّ مَا خَلَقَ، وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ، وَمِن شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ، وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ", fadl: "من قالهما حين يصبح وحين يمسى كفته من كل شيء", numberOfTimes: "ثلاث مرات"))
        
        zikrModels.append(ZikrModel(title: "بِسْمِ اللهِ الرَّحْمنِ الرَّحِيم", zikr: "قُلْ أَعُوذُ بِرَبِّ النَّاسِ، مَلِكِ النَّاسِ، إِلَهِ النَّاسِ، مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ، الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ، مِنَ الْجِنَّةِ وَ النَّاسِ", fadl: "من قالهما حين يصبح وحين يمسى كفته من كل شيء", numberOfTimes: "ثلاث مرات"))
    }
    
    func getTextToShare(from cell: ZikrTableViewCell) -> [String] {
        var textToShare = [String]()
        guard let title = cell.title.text, let zikr = cell.zikr.text, let fadl = cell.fadl.text, let numberOfTimes = cell.numberOfTimes.text else {
            return [""]
        }
        textToShare.append(title)
        textToShare.append(zikr)
        textToShare.append(fadl)
        textToShare.append(numberOfTimes)
        return textToShare
    }
}

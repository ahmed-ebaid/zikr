//
//  ZikrQuranViewModel.swift
//  zikr
//
//  Created by Ahmed Ebaid on 6/10/18.
//  Copyright © 2018 Ahmed Ebaid. All rights reserved.
//

import Foundation

class ZikrQuranViewModel {
    var morningZikrModels: [ZikrModel]!
    var eveningZikrModels: [ZikrModel]!

    init() {
        morningZikrModels = []
        eveningZikrModels = []
        configureMorningAzkar()
        configureEveningAzkar()
    }

    func configureMorningAzkar() {
        morningZikrModels.append(ZikrModel(title: "أَعُوذُ بِاللهِ مِنْ الشَّيْطَانِ الرَّجِيمِ", zikr: "اللّهُ لاَ إِلَهَ إِلاَّ هُوَ الْحَيُّ الْقَيُّومُ لاَ تَأْخُذُهُ سِنَةٌ وَلاَ نَوْمٌ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلاَّ بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلاَ يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلاَّ بِمَا شَاء وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالأَرْضَ وَلاَ يَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُ", fadl: "من قالها حين يصبح أجير من الجن حتى يمسى ومن قالها حين يمسى أجير من الجن حتى يصبح", numberOfTimes: "مرة واحدة"))

        morningZikrModels.append(ZikrModel(title: "بِسْمِ اللهِ الرَّحْمنِ الرَّحِيم", zikr: "قُلْ هُوَ اللَّهُ أَحَدٌ، اللَّهُ الصَّمَدُ، لَمْ يَلِدْ وَلَمْ يُولَدْ، وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ", fadl: "مَنْ قَالَهَا حِينَ يُصْبِحُ ثَلَاثُ مَرَّاتٍ، تَكْفِيهِ مِنْ كُلِّ شَيْءٍ", numberOfTimes: "ثَلاَثَ مَرَّاتٍ"))

        morningZikrModels.append(ZikrModel(title: "بِسْمِ اللهِ الرَّحْمنِ الرَّحِيم", zikr: "قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ، مِن شَرِّ مَا خَلَقَ، وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ، وَمِن شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ، وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ", fadl: "مَنْ قَالَهَا حِينَ يُصْبِحُ ثَلَاثُ مَرَّاتٍ، تَكْفِيهِ مِنْ كُلِّ شَيْءٍ", numberOfTimes: "ثَلاَثَ مَرَّاتٍ"))

        morningZikrModels.append(ZikrModel(title: "بِسْمِ اللهِ الرَّحْمنِ الرَّحِيم", zikr: "قُلْ أَعُوذُ بِرَبِّ النَّاسِ، مَلِكِ النَّاسِ، إِلَهِ النَّاسِ، مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ، الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ، مِنَ الْجِنَّةِ وَ النَّاسِ", fadl: "مَنْ قَالَهَا حِينَ يُصْبِحُ ثَلَاثُ مَرَّاتٍ، تَكْفِيهِ مِنْ كُلِّ شَيْءٍ", numberOfTimes: "ثَلاَثَ مَرَّاتٍ"))

        morningZikrModels.append(ZikrModel(title: "", zikr: " أَصْبَحْنا وَأَصْبَحَ المُلْكُ لله وَالحَمدُ لله، لا إلهَ إلاّ اللّهُ وَحدَهُ لا شَريكَ لهُ، لهُ المُلكُ ولهُ الحَمْد، وهُوَ على كلّ شَيءٍ قدير، رَبِّ أسْأَلُكَ خَيرَ ما في هذا اليوم وَخَيرَ ما بَعْدَه، وَأَعوذُ بِكَ مِنْ شَرِّ ما في هذا اليوم وَشَرِّ ما بَعْدَه، رَبِّ أَعوذُ بِكَ مِنَ الْكَسَلِ وَسوءِ الْكِبَر، رَبِّ أَعوذُ بِكَ مِنْ عَذابٍ في النّارِ وَعَذابٍ في القَبْر.", fadl: "", numberOfTimes: "مرة واحدة"))
    }

    func configureEveningAzkar() {
        eveningZikrModels.append(ZikrModel(title: "أَعُوذُ بِاللهِ مِنْ الشَّيْطَانِ الرَّجِيمِ", zikr: "اللّهُ لاَ إِلَهَ إِلاَّ هُوَ الْحَيُّ الْقَيُّومُ لاَ تَأْخُذُهُ سِنَةٌ وَلاَ نَوْمٌ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلاَّ بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلاَ يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلاَّ بِمَا شَاء وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالأَرْضَ وَلاَ يَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُ", fadl: "من قالها حين يمسى أجير من الجن حتى يصبح", numberOfTimes: "مرة واحدة"))

        eveningZikrModels.append(ZikrModel(title: "بِسْمِ اللهِ الرَّحْمنِ الرَّحِيم", zikr: "قُلْ هُوَ اللَّهُ أَحَدٌ، اللَّهُ الصَّمَدُ، لَمْ يَلِدْ وَلَمْ يُولَدْ، وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ", fadl: "مَنْ قَالَهَا حِينَ يُمْسِي ثَلَاثُ مَرَّاتٍ، تَكْفِيهِ مِنْ كُلِّ شَيْءٍ", numberOfTimes: "ثَلاَثَ مَرَّاتٍ"))

        eveningZikrModels.append(ZikrModel(title: "بِسْمِ اللهِ الرَّحْمنِ الرَّحِيم", zikr: "قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ، مِن شَرِّ مَا خَلَقَ، وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ، وَمِن شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ، وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ", fadl: "مَنْ قَالَهَا حِينَ يُصْبِحُ ثَلَاثُ مَرَّاتٍ، تَكْفِيهِ مِنْ كُلِّ شَيْءٍ", numberOfTimes: "ثَلاَثَ مَرَّاتٍ"))

        eveningZikrModels.append(ZikrModel(title: "بِسْمِ اللهِ الرَّحْمنِ الرَّحِيم", zikr: "قُلْ أَعُوذُ بِرَبِّ النَّاسِ، مَلِكِ النَّاسِ، إِلَهِ النَّاسِ، مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ، الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ، مِنَ الْجِنَّةِ وَ النَّاسِ", fadl: "مَنْ قَالَهَا حِينَ يُصْبِحُ ثَلَاثُ مَرَّاتٍ، تَكْفِيهِ مِنْ كُلِّ شَيْءٍ", numberOfTimes: "ثَلاَثَ مَرَّاتٍ"))

        eveningZikrModels.append(ZikrModel(title: "", zikr: " أَصْبَحْنا وَأَصْبَحَ المُلْكُ لله وَالحَمدُ لله، لا إلهَ إلاّ اللّهُ وَحدَهُ لا شَريكَ لهُ، لهُ المُلكُ ولهُ الحَمْد، وهُوَ على كلّ شَيءٍ قدير، رَبِّ أسْأَلُكَ خَيرَ ما في هذا اليوم وَخَيرَ ما بَعْدَه، وَأَعوذُ بِكَ مِنْ شَرِّ ما في هذا اليوم وَشَرِّ ما بَعْدَه، رَبِّ أَعوذُ بِكَ مِنَ الْكَسَلِ وَسوءِ الْكِبَر، رَبِّ أَعوذُ بِكَ مِنْ عَذابٍ في النّارِ وَعَذابٍ في القَبْر.", fadl: "", numberOfTimes: "مرة واحدة"))
    }

    func getTextToShare(from cell: ZikrTableViewCell) -> [String] {
        var textToShare = [String]()
        guard let title = cell.bismllahTitle.text, let zikr = cell.zikr.text, let fadl = cell.fadl.text, let numberOfTimes = cell.numberOfTimes.text else {
            return [""]
        }
        textToShare.append(title)
        textToShare.append(zikr)
        textToShare.append(fadl)
        textToShare.append(numberOfTimes)
        return textToShare
    }
    
    func getControlCellIndexPath(using controlIndexPath: IndexPath, tappedIndexPath: IndexPath) -> IndexPath {
        let tappedRow = tappedIndexPath.row
        let tappedSection = tappedIndexPath.section
        
        return controlIndexPath.row > tappedRow ? IndexPath(row: tappedRow + 1, section: tappedSection) : IndexPath(row: tappedRow, section: tappedSection)
    }
    
    func getDataCellRow(using controlIndexPath: IndexPath?, tappedIndexPath: IndexPath) -> Int {
        guard let controlRow = controlIndexPath else {
            return tappedIndexPath.row
        }
        
        let tappedRow = tappedIndexPath.row
        return tappedRow > controlRow.row ? tappedRow - 1 : tappedRow
    }
}

//
//  Data.swift
//  KK-hw3
//
//  Created by 朱冠儒 on 2021/4/8.
//

import Foundation
import AVFoundation
import SwiftUI

struct Vocab
{
    var KK: String
    var index: Int
    var vCGRect: CGRect = CGRect.zero
    var eng: String
}
var ˋɑrtIst = [//artist
    Vocab(KK: "ˋ", index: 0, eng: "artist"),
    Vocab(KK: "ɑ", index: 1, eng: "artist"),
    Vocab(KK: "r", index: 2, eng: "artist"),
    Vocab(KK: "t", index: 3, eng: "artist"),
    Vocab(KK: "I", index: 4, eng: "artist"),
    Vocab(KK: "s", index: 5, eng: "artist"),
    Vocab(KK: "t", index: 6, eng: "artist"),
    Vocab(KK: "ˋɑrtIst", index: -1, eng: "artist"),  //-1, pic
]
var ˋbebI = [//baby
    Vocab(KK: "ˋ", index: 0, eng: "baby"),
    Vocab(KK: "b", index: 1, eng: "baby"),
    Vocab(KK: "e", index: 2, eng: "baby"),
    Vocab(KK: "b", index: 3, eng: "baby"),
    Vocab(KK: "I", index: 4, eng: "baby"),
    Vocab(KK: "ˋbebI", index: -1, eng: "baby"),  //-1, pic
]
var ˋbɑtL = [//bottle
    Vocab(KK: "ˋ", index: 0, eng: "bottle"),
    Vocab(KK: "b", index: 1, eng: "bottle"),
    Vocab(KK: "ɑ", index: 2, eng: "bottle"),
    Vocab(KK: "t", index: 3, eng: "bottle"),
    Vocab(KK: "L", index: 4, eng: "bottle"),
    Vocab(KK: "ˋbɑtL", index: -1, eng: "bottle"),  //-1, pic
]
var brєd = [//bread
    Vocab(KK: "b", index: 0, eng: "bread"),
    Vocab(KK: "r", index: 1, eng: "bread"),
    Vocab(KK: "є", index: 2, eng: "bread"),
    Vocab(KK: "d", index: 3, eng: "bread"),
    Vocab(KK: "brєd", index: -1, eng: "bread"),  //-1, pic
]
var ˋbrʌðZ = [//brother
    Vocab(KK: "ˋ", index: 0, eng: "brother"),
    Vocab(KK: "b", index: 1, eng: "brother"),
    Vocab(KK: "r", index: 2, eng: "brother"),
    Vocab(KK: "ʌ", index: 3, eng: "brother"),
    Vocab(KK: "ð", index: 4, eng: "brother"),
    Vocab(KK: "Z", index: 5, eng: "brother"),
    Vocab(KK: "ˋbrʌðZ", index: -1, eng: "brother"),  //-1, pic
]
var ˋkændL = [//candle
    Vocab(KK: "ˋ", index: 0, eng: "candle"),
    Vocab(KK: "k", index: 1, eng: "candle"),
    Vocab(KK: "æ", index: 2, eng: "candle"),
    Vocab(KK: "n", index: 3, eng: "candle"),
    Vocab(KK: "d", index: 4, eng: "candle"),
    Vocab(KK: "L", index: 5, eng: "candle"),
    Vocab(KK: "ˋkændL", index: -1, eng: "candle"),  //-1, pic
]
var tʃєs = [//chess
    Vocab(KK: "t", index: 0, eng: "chess"),
    Vocab(KK: "ʃ", index: 1, eng: "chess"),
    Vocab(KK: "є", index: 2, eng: "chess"),
    Vocab(KK: "s", index: 3, eng: "chess"),
    Vocab(KK: "tʃєs", index: -1, eng: "chess"),  //-1, pic
]
var ˋkʒI = [//curry
    Vocab(KK: "ˋ", index: 0, eng: "curry"),
    Vocab(KK: "k", index: 1, eng: "curry"),
    Vocab(KK: "ʒ", index: 2, eng: "curry"),
    Vocab(KK: "I", index: 3, eng: "curry"),
    Vocab(KK: "ˋkʒI", index: -1, eng: "curry"),  //-1, pic
]
var kєtʃәp = [//ketchup
    Vocab(KK: "k", index: 0, eng: "ketchup"),
    Vocab(KK: "є", index: 1, eng: "ketchup"),
    Vocab(KK: "t", index: 2, eng: "ketchup"),
    Vocab(KK: "ʃ", index: 3, eng: "ketchup"),
    Vocab(KK: "ә", index: 4, eng: "ketchup"),
    Vocab(KK: "p", index: 5, eng: "ketchup"),
    Vocab(KK: "kєtʃәp", index: -1, eng: "ketchup"),  //-1, pic
]
var ˋmʌnI = [//money
    Vocab(KK: "ˋ", index: 0, eng: "money"),
    Vocab(KK: "m", index: 1, eng: "money"),
    Vocab(KK: "ʌ", index: 2, eng: "money"),
    Vocab(KK: "n", index: 3, eng: "money"),
    Vocab(KK: "I", index: 4, eng: "money"),
    Vocab(KK: "ˋmʌnI", index: -1, eng: "money"),  //-1, pic
]
var pәˋlis = [//police
    Vocab(KK: "p", index: 0, eng: "police"),
    Vocab(KK: "ә", index: 1, eng: "police"),
    Vocab(KK: "ˋ", index: 2, eng: "police"),
    Vocab(KK: "l", index: 3, eng: "police"),
    Vocab(KK: "i", index: 4, eng: "police"),
    Vocab(KK: "s", index: 5, eng: "police"),
    Vocab(KK: "pәˋlis", index: -1, eng: "police"),  //-1, pic
]
var ˋsɑkZ = [//soccer
    Vocab(KK: "ˋ", index: 0, eng: "soccer"),
    Vocab(KK: "s", index: 1, eng: "soccer"),
    Vocab(KK: "ɑ", index: 2, eng: "soccer"),
    Vocab(KK: "k", index: 3, eng: "soccer"),
    Vocab(KK: "Z", index: 4, eng: "soccer"),
    Vocab(KK: "ˋsɑkZ", index: -1, eng: "soccer"),  //-1, pic
]
var stɑr = [//star
    Vocab(KK: "s", index: 0, eng: "star"),
    Vocab(KK: "t", index: 1, eng: "star"),
    Vocab(KK: "ɑ", index: 2, eng: "star"),
    Vocab(KK: "r", index: 3, eng: "star"),
    Vocab(KK: "stɑr", index: -1, eng: "star"),  //-1, pic
]
var tæŋk = [//tank
    Vocab(KK: "t", index: 0, eng: "tank"),
    Vocab(KK: "æ", index: 1, eng: "tank"),
    Vocab(KK: "ŋ", index: 2, eng: "tank"),
    Vocab(KK: "k", index: 3, eng: "tank"),
    Vocab(KK: "tæŋk", index: -1, eng: "tank"),  //-1, pic
]
var vocArray = [ˋɑrtIst, ˋbebI, brєd, ˋbrʌðZ, ˋkændL, tʃєs, ˋkʒI, kєtʃәp, ˋmʌnI, pәˋlis, ˋsɑkZ, tæŋk]


var musicPlayer = AVQueuePlayer()
var firstIntoAPP = true

//
//  main.swift
//  translitor
//
//  Created by Yerbol Kopzhassar on 15/06/2017.
//  Copyright © 2017 Yerbol Kopzhassar. All rights reserved.
//

import Foundation
let alphabet = [
    "А": "A",
    "а": "a",
    "Ә": "Ae",
    "ә": "ae",
    "Б": "B",
    "б": "b",
    "В": "V",
    "в": "v",
    "Г": "G",
    "г": "g",
    "Ғ": "Gh",
    "ғ": "gh",
    "Д": "D",
    "д": "d",
    "Е": "E",
    "е": "e",
    "Ё": "",
    "ё": "",
    "Ж": "Zh",
    "ж": "zh",
    "З": "Z",
    "з": "z",
    "Й": "J",
    "й": "J",
    "К": "K",
    "к": "k",
    "Қ": "Q",
    "қ": "q",
    "Л": "L",
    "л": "l",
    "М": "M",
    "м": "m",
    "Н": "N",
    "н": "n",
    "Ң": "Ng",
    "ң": "ng",
    "О": "O",
    "о": "o",
    "Ө": "oe",
    "ө": "oe",
    "П": "P",
    "п": "p",
    "Р": "R",
    "р": "r",
    "С": "S",
    "с": "s",
    "Т": "T",
    "т": "t",
    "У": "U",
    "у": "u",
    "Ү": "Ue",
    "ү": "ue",
    "Ұ": "U",
    "ұ": "U",
    "Ф": "F",
    "ф": "f",
    "Х": "H",
    "х": "h",
    "Һ": "H",
    "һ": "h",
    "Ц": "C",
    "ц": "c",
    "Ч": "Ch",
    "ч": "ch",
    "Ш": "Sh",
    "ш": "sh",
    "Щ": "Sh",
    "щ": "sh",
    "Ъ": "",
    "ъ": "",
    "Ы": "I",
    "ы": "i",
    "І": "I",
    "і": "i",
    "Ь": "",
    "ь": "",
    "Э": "E",
    "э": "e",
    "Ю": "Yu",
    "ю": "yu",
    "Я": "Ya",
    "я": "ya",
    "И": "I",
    "и": "i"
]

func isAshik(_ letter: Character) -> Bool{
    let open = "аАоОәӘөӨеЕ"
    if open.characters.contains(letter){
        return true}
    return false
}
func isZhuan(_ letter: Character) -> Bool{
    let open = "aаАаААоОұҰуУыЫ"
    if open.characters.contains(letter){
        return true}
    return false
}
func isErindik(_ letter: Character) -> Bool{
    let open = "оОөӨуУүҮұҰ"
    if open.characters.contains(letter){
        return true}
    return false
}
func isDaus(_ letter: Character) -> Bool{
    let daus = "аааоАaАОеЕыЫіІоөӨұҮүҰ"
    if daus.characters.contains(letter){
        return true
    }
    return false
}
func isKatan(_ letter: Character) -> Bool{
    let open = "пПкКқҚтТсСфФхХцЦчЧшШщЩһ"
    if open.characters.contains(letter){
        return true}
    return false
}
func isUyan(_ letter: Character) -> Bool{
    let open = "бБвВгГғҒдДжЖзЗ"
    if open.characters.contains(letter){
        return true}
    return false
}
func isAuiz(_ letter: Character) -> Bool{
    let auiz = 	"лЛрРйЙуУ"
    if auiz.characters.contains(letter){
        return true}
    return false
}
func isTalga(_ letter: Character) -> Bool{
    let talga = "ғҒқҚ"
    if talga.characters.contains(letter){
        return true}
    return false
}

func isWordAuiz(_ input: String) ->Bool{
    for letter in input.characters{
        if isAuiz(letter){
            return true}
    }
    return false
}

func isHard(_ input: String) -> Bool{
    let soft = "әӘіІөӨүҮеЕиИ"
    for letter in input.characters{
        if soft.characters.contains(letter){
            return false}
    }
    return true
}

func isI(word: String, iIndex: Int) ->Bool{
    var vWord = word
    let indexOf = iIndex + 1
    vWord.insert(" ", at: word.startIndex)
    vWord+=" "
    let nIndex = vWord.characters.index(vWord.startIndex, offsetBy: indexOf+1)
    let nLet = vWord[nIndex]
    let pIndex = vWord.characters.index(vWord.startIndex, offsetBy: indexOf-1)
    let pLet = vWord[pIndex]
    if isTalga(pLet) || (isUyan(nLet) && isAshik((vWord[vWord.characters.index(vWord.startIndex, offsetBy: indexOf+2)]))) || isDaus(nLet){
        return false
    }
    else{
        return true
    }
}
func isNHard(_ word: String, _ nIndex: Int) -> Bool{
    var vWord = word
    let indexOf = nIndex
    let endIndex = vWord.characters.endIndex
    let neIndex = vWord.characters.index(vWord.startIndex, offsetBy: indexOf+1)
    if ((endIndex==neIndex) && isTughanSeptik(word: word)) || isWordZhuan(word, nIndex) || isNExtension(word){
        return true
    }
    return false
}
func isTughanSeptik(word: String) -> Bool{
    let okonchaniya = ["дын","дин","тын","тин","нин","нын","дін","тін","нін", "син", "ін", "ніз"]
    for okon in okonchaniya{
        if word.hasSuffix(okon){
            return true
        }
    }
    return false
}
func isNExtension(_ word: String) -> Bool{
    let okonchaniya = ["ніз"]
    for okon in okonchaniya{
        if word.hasSuffix(okon){
            return true
        }
    }
    return false
}
func isWordZhuan(_ word:String, _ exceptLetterIndex: Int) -> Bool{
    let index = word.characters.index(word.startIndex, offsetBy: exceptLetterIndex)
    let exceptletter = word[index]
    for letter in word.characters{
        if letter == exceptletter{
            continue
        }
        if isDaus(letter){
            if !isZhuan(letter){
                return false
            }
        }
    }
    return true
}
func isYo(word: String, oIndex: Int)->Bool{
    var vWord = word.lowercased()
    let indexOf = oIndex + 1
    vWord.insert(" ", at: word.startIndex)
    vWord+=" "
    
    let nIndex = vWord.characters.index(vWord.startIndex, offsetBy: indexOf+1)
    let nLet = vWord[nIndex]
    
    let pIndex = vWord.characters.index(vWord.startIndex, offsetBy: indexOf-1)
    let pLet = vWord[pIndex]
    
    if (nLet=="з" || !isWordZhuan(word, oIndex)) && !isTughanSeptik(word: word){
        return true
    }
    return false
}
func defineY(word: String, yIndex: Int) ->String{
    
    var yWord = word.lowercased()
    let last = yWord.endIndex
    let yIflast = (last == yWord.characters.index(yWord.startIndex, offsetBy: yIndex+1))
    let indexOf = yIndex + 1
    yWord.insert(" ", at: yWord.startIndex)
    yWord+=" "
    
    let nIndex = yWord.characters.index(yWord.startIndex, offsetBy: indexOf+1)
    let nLet = yWord[nIndex]
    
    let pIndex = yWord.characters.index(yWord.startIndex, offsetBy: indexOf-1)
    let pLet = yWord[pIndex]
    
    if isDaus(pLet) || isDaus(nLet) || yIflast{
        return "у"
    }
    if !isWordZhuan(word,yIndex){
        return "ү"
    }
    return "ұ"
}

func isKHard(_ word: String, _ kIndex: Int) -> Bool{
    var kWord = word.lowercased()
    let indexOf = kIndex + 1
    kWord.insert(" ", at: kWord.startIndex)
    kWord+=" "
    let nIndex = kWord.characters.index(kWord.startIndex, offsetBy: indexOf+1)
    let nLet = kWord[nIndex]
    if isZhuan(nLet) || isWordZhuan(word, kIndex){
        return true
    }
    else{
        return false
    }
}

func easyChange(input: String) ->String {
    var returnString = ""
    let words = input.components(separatedBy: " ")
    for word in words{
        let chars = word.characters.map { String($0) }
        _ = chars.reversed()
        
        for var i in (0..<chars.count){
            var letter = chars[i].lowercased()
            switch letter{
            case "а":
                if isHard(word) || !isWordAuiz(word){
                    returnString += "а"
                }
                else{
                    returnString += "ә"
                }
            case "и":
                if isI(word: word, iIndex: i){
                    returnString += "і"
                }
                else{
                    returnString += "и"
                }
            case "у":
                returnString += defineY(word: word, yIndex: i)
            case "о":
                if isYo(word: word, oIndex: i){
                    returnString += "ө"
                }
                else{
                    returnString += "о"
                }
            default:
                returnString += letter
            }
            
            
        }
        returnString += " "
    }
    return translate(input: returnString)
}
func translate(input: String) ->String{
    var returnString = ""
    let words = input.components(separatedBy: " ")
    for word in words{
        let chars = word.characters.map { String($0) }
        _ = chars.reversed()
        
        for var i in (0..<chars.count){
            var letter = chars[i].lowercased()
            switch letter{
            case "а":
                if isHard(word) || !isWordAuiz(word){
                    returnString += "а"
                }
                else{
                    returnString += "ә"
                }
            case "г":
                if isHard(word){
                    returnString += "ғ"
                }
                else{
                    returnString += "г"
                }
            case "и":
                if isI(word: word, iIndex: i){
                    returnString += "і"
                }
                else{
                    returnString += "и"
                }
            case "к":
                if isKHard(word,i){
                    returnString += "қ"
                }
                else{
                    returnString += "к"
                }
            case "н":
                if isNHard(word,i){
                    returnString += "ң"
                }
                else{
                    returnString += "н"
                }
            case "о":
                if isYo(word: word, oIndex: i){
                    returnString += "ө"
                }
                else{
                    returnString += "о"
                }
            case "у":
                returnString += defineY(word: word, yIndex: i)
                
            default:
                returnString += letter
            }
            
        }
        returnString += " "
    }
    return returnString
}

func translateLatin(_ input: String) -> String{
    var newText = String()
    newText = ""
    // ehh shyas bi na swift 3 pisat
    for char in input.characters{
        if let newchar = alphabet["\(char)"] {
            newText += newchar
        }
        else{
            newText += String(char)
        }
    }
    return newText
}











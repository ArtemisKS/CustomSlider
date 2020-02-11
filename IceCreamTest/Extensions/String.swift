//
//  String.swift
//  IceCreamTest
//
//  Created by Artem Kuprijanets on 2/11/20.
//  Copyright © 2020 Artem Kuprijanets. All rights reserved.
//

import Foundation

extension String {
  
  enum NounGender: Int, CaseIterable {
    case masculine, feminine, neutral
  }
  
  var vowels: String {
    return "аоиеёэыуюяії"
  }
  
  var hardConsonants: String {
    return "жшц"
  }
  
  var lastIndex: String.Index {
    return index(before: endIndex)
  }
  
  private func getLocSymbol(_ char: Character) -> Character {
    
    let uaLocale = Globals.Lang.isUA
    
    switch char {
    case "и":
      return uaLocale ? "і" : char
    case "ы":
      return uaLocale ? "и" : char
    case "я":
      return uaLocale ? "ї" : char
    default:
      return char
    }
  }
  
  private func returnOnlyWovel() -> String.Index? {
    var cnt = 0
    var ind: String.Index!
    for ch in self {
      if vowels.contains(ch) {
        cnt += 1
        ind = firstIndex(of: ch)
      }
    }
    return cnt == 1 ? ind : nil
  }
  
  private func deleteVowelIfOnly() -> String {
    var newSelf = self
    if let ind = returnOnlyWovel() {
      newSelf.remove(at: ind)
    }
    return newSelf
  }
  
  private func figureOutMasculineEnding(number: String) -> String {
    var newSelf = self
    let uaLocale = Globals.Lang.isUA
    guard var num = Int(number.suffix(2)) else { return newSelf }
    num = (10...20).contains(num) ? 5 : num % 10
    switch num {
    case 0, 5...9:
      if newSelf.last! == "ь" {
        if !uaLocale {
          newSelf = deleteVowelIfOnly()
        }

        newSelf.remove(at: newSelf.lastIndex)
        newSelf.append("ей")
      } else {
        newSelf.append(!uaLocale ? "ов" : "ів")
      }
    case 2..<5:
      if newSelf.last! == "ь" {
        if !uaLocale {
          newSelf = deleteVowelIfOnly()
        }
        newSelf.remove(at: newSelf.lastIndex)
        newSelf.append("я")
      } else {
        newSelf.append(
          uaLocale && newSelf.returnOnlyWovel() != nil ? "и" : "а")
      }
    default:
      break
    }
    return newSelf
  }
  
  private func figureOutFeminineEnding(number: String) -> String {
    var newSelf = self
    guard var num = Int(number.suffix(2)) else { return newSelf }
    num = (10...20).contains(num) ? 5 : num % 10
    switch num {
    case 0, 5...9:
      let lastChar = newSelf.remove(at: newSelf.lastIndex)
      if lastChar != "а" && lastChar != "я" {
        newSelf.append("ь")
      } else if Globals.Lang.isUA && lastChar == "я" {
        newSelf.append("й")
      }
    case 2..<5:
      let lastChar = newSelf.remove(at: newSelf.lastIndex)
      if !vowels.contains(newSelf[newSelf.lastIndex]) {
        let hardVowel = Globals.Lang.isUA ? "и" : "ы"
        let softVowel = Globals.Lang.isUA ? "і" : "и"
        newSelf.append(lastChar == "а" ? hardVowel : softVowel)
      } else {
        newSelf.append(getLocSymbol("я"))
      }
    case 1:
      if last == "а" {
        _ = newSelf.remove(at: newSelf.lastIndex)
        newSelf.append("у")
      }
    default:
      break
    }
    return newSelf
  }
  
  private func figureOutNeutralEnding(number: String) -> String {
    var newSelf = self
    guard var num = Int(number.suffix(2)) else { return newSelf }
    num = (10...20).contains(num) ? 5 : num % 10
    switch num {
    case 0, 5...9:
      let lastChar = newSelf.remove(at: newSelf.lastIndex)
      let lastCurChar = newSelf[newSelf.lastIndex]
      if !hardConsonants.contains(lastCurChar) &&
        lastChar == "е" {
        newSelf.append("\((vowels.contains(lastCurChar)) ? "" : "\(lastChar)")й")
      } else if lastChar == "о" {
        newSelf.insert("o", at: newSelf.lastIndex)
      }
    case 2..<5:
      let lastChar = newSelf.remove(at: newSelf.lastIndex)
      newSelf.append(lastChar == "е" &&
        !hardConsonants.contains(newSelf[newSelf.lastIndex]) ? "я" : "а")
    default:
      break
    }
    return newSelf
  }
  
  func getNounOfNumber(
    _ number: String,
    andGender gender: NounGender = .masculine) -> String {
    guard Int(number) != nil else { return self }
    var newSelf = self
    switch gender {
    case .masculine:
      newSelf = figureOutMasculineEnding(number: number)
    case .feminine:
      newSelf = figureOutFeminineEnding(number: number)
    default:
      newSelf = figureOutNeutralEnding(number: number)
    }
    return newSelf
  }
}

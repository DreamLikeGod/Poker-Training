//
//  Settings.swift
//  Poker
//
//  Created by Егор on 22.10.2023.
//

import Foundation
import UIKit

class Settings {
    
    public static let shared = Settings()
    
    private init() {}
    
    private var background: UIColor {
        switch UserDefaults.standard.integer(forKey: "color") {
        case 0:
            return UIColor(named: "blue") ?? .black
        case 1:
            return UIColor(named: "green") ?? .black
        case 2:
            return UIColor(named: "wine") ?? .black
        default:
            return .gray
        }
    }
    
    private var stage: Int {
        return UserDefaults.standard.integer(forKey: "cards")
    }
    
    public func saveData(withCards stage: Int, andBackground color: UIColor) {
        var colorVar = -1
        switch color {
        case UIColor(named: "blue")!:
            colorVar = 0
        case UIColor(named: "green")!:
            colorVar = 1
        case UIColor(named: "wine")!:
            colorVar = 2
        default:
            colorVar = -1
        }
        print(colorVar)
        UserDefaults.standard.set(stage, forKey: "cards")
        UserDefaults.standard.set(colorVar, forKey: "color")
    }
    
    public func getData() -> (Int, UIColor) {
        return (stage, background)
    }
    
}

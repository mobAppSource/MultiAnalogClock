//
//  MainParameters.swift
//  multiWatchApp
//
//  Created by Master on 6/21/16.
//  Copyright © 2016 Master. All rights reserved.
//

import Foundation
import UIKit
import KeychainSwift

// Corner radius of view
let rCornerRadius: CGFloat = 10
var wView: CGFloat!
var hView: CGFloat!
let rCenterPoint: CGFloat = 5

let bkColor = UIColor(red: 119/255, green: 130/255, blue: 168/255, alpha: 1)
//DigitClockView's mainview margins
let digit_margin_x: CGFloat = 40
let digit_margin_y: CGFloat = 40

//Alarm, setting button's margins
let alarm_margin_x: CGFloat = 63
let alarm_margin_y: CGFloat = 63
let alarm_w: CGFloat = 50
let alarm_h: CGFloat = 50
let setting_margin_x: CGFloat = 63
let setting_margin_y: CGFloat = 63
let setting_w: CGFloat = 50
let setting_h: CGFloat = 50


//Tint Color for setting and alarm button
let alarmTintColor = UIColor(red: 0.12, green: 0.12, blue: 0.89, alpha: 1)
let settingTintColor = UIColor(red: 0.12, green: 0.12, blue: 0.89, alpha: 1)

//Background big digit label in BigDigitClockView
var bigDigitLabel_margin_y: CGFloat = 40
let backFontSizeBigDigitClockView: CGFloat = CGFloat(round(UIScreen.mainScreen().bounds.size.height/2))
let hourFontSizeBigDigitClockView: CGFloat = CGFloat(round(UIScreen.mainScreen().bounds.size.height/10))
let cityFontSizeBigDigitClockView: CGFloat = CGFloat(round(UIScreen.mainScreen().bounds.size.height/50))
let rDotView: CGFloat = 10
let keyChainManager = KeychainSwift()
//Alarm music sorts
let songs: [String] = ["909 at 117-long", "Arpeggiate-4-long","Boss 110-3-long","Calculating-2-long","Jitterchord-2-long","Noise Chip-long","wBeep-long"]

//Color define
var fstColor: UIColor!
var secColor: UIColor!
var thdColor: UIColor!
//getting colors palette
var paletteSet: [[[Int]]] = []
var myDicData: NSDictionary?

//
var hours = [6, 13, 10, 4, 6]
var cities = ["AMS", "TYO", "BKK", "LON", "LOC", ""]
var city_normal_Name = ["Europe/Amsterdam", "Asia/Tokyo", "Asia/Bangkok","Europe/London","Asia/Tokyo"]





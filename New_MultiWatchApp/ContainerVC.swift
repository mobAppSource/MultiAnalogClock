//
//  ContainerVC.swift
//  New_MultiWatchApp
//
//  Created by Master on 6/29/16.
//  Copyright © 2016 Master. All rights reserved.
//

import UIKit
import EZSwipeController


class ContainerVC: EZSwipeController {

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
    }
    
    override func setupView() {
        datasource = self
        navigationBarShouldNotExist = true
        self.readData()
        if let colorIndex = keyChainManager.get("selectedColor") {
            let colorIndex = Int(colorIndex)
            let colors = paletteSet[colorIndex!]
            print("Colors:\(colors)/ \(colorIndex)")
            fstColor = UIColor(red: CGFloat(colors[0][0])/255, green: CGFloat(colors[0][1])/255, blue: CGFloat(colors[0][2])/255, alpha: 1)
            secColor = UIColor(red: CGFloat(colors[1][0])/255, green: CGFloat(colors[1][1])/255, blue: CGFloat(colors[1][2])/255, alpha: 1)
            thdColor = UIColor(red: CGFloat(colors[2][0])/255, green: CGFloat(colors[2][1])/255, blue: CGFloat(colors[2][2])/255, alpha: 1)
        }else{
            let colors = paletteSet[0]
            fstColor = UIColor(red: CGFloat(colors[0][0])/255, green: CGFloat(colors[0][1])/255, blue: CGFloat(colors[0][2])/255, alpha: 1)
            secColor = UIColor(red: CGFloat(colors[1][0])/255, green: CGFloat(colors[1][1])/255, blue: CGFloat(colors[1][2])/255, alpha: 1)
            thdColor = UIColor(red: CGFloat(colors[2][0])/255, green: CGFloat(colors[2][1])/255, blue: CGFloat(colors[2][2])/255, alpha: 1)
        }
    }

}

extension ContainerVC: EZSwipeControllerDataSource{
    func viewControllerData() -> [UIViewController] {
        let homeVC = HomeClockVC()
        let digitVC = DigitClockVC()
        let imgVC = ImgClockVC()
        let bigVC = BigDigitClockVC()
        
        return [homeVC, digitVC, imgVC, bigVC]
    }
 
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
extension ContainerVC{
    //Read .plist file contents
    func readData()
    {
        if let path = NSBundle.mainBundle().pathForResource("palettes", ofType: ".plist"){
            myDicData = NSDictionary(contentsOfFile: path)
        }
        if let dict = myDicData{
            for (_, value) in dict
            {
                if value is NSArray{
                    var colorSet: [[Int]] = []
                    var color: [Int] = []
                    for items in value as! NSArray
                    {
                        if let str = items as? String{
                            let strArr = str.componentsSeparatedByString(", ")
                            for item in strArr{
                                color.append(Int(item)!)
                            }
                        }
                        colorSet.append(color)
                        color.removeAll(keepCapacity: false)
                    }
                    paletteSet.append(colorSet)
                    colorSet.removeAll(keepCapacity: false)
                }
            }
        }
    }
    func switchKey<T, U>(inout myDict: [T:U], fromKey: T, toKey: T) {
        if let entry = myDict.removeValueForKey(fromKey) {
            myDict[toKey] = entry
        }
    }
}

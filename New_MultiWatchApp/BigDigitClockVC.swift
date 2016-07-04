//
//  BigDigitClock.swift
//  multiWatchApp
//
//  Created by Master on 6/21/16.
//  Copyright © 2016 Master. All rights reserved.
//

import UIKit
import BEMAnalogClock

class BigDigitClockVC: UIViewController{
    
    
    var btn_alarm: UIButton!
    var btn_setting: UIButton!


    var backClock: BEMAnalogClockView!
    var backMinLabel: UILabel!
    var clockView: UIView!
    var secClock: UIView!
    var thdClock: UIView!
    var forClock: UIView!
    
    //parameters
    let hours = [6, 10, 2, 4]
    let cities = ["AMS", "TYO", "BKK", "LON"]
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = thdColor
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.hidden = true
        self.view.layer.cornerRadius = rCornerRadius
        self.view.layer.masksToBounds = true
        self.view.layer.borderColor = UIColor.whiteColor().CGColor
        self.view.layer.borderWidth = 0.5
        self.view.backgroundColor = thdColor
        
        //Display the analog clock
        self.init_back_clock()
        //displaying the big digitClock data on the main view
        self.init_labels()
        //Buttons
        self.init_buttons()
    }
    func init_back_clock()
    {
        //
        self.backClock = BEMAnalogClockView(frame: CGRect(x: 0,
                                                          y: self.view.frame.height/2-self.view.frame.width/2,
                                                      width: self.view.frame.width,
                                                     height: self.view.frame.width))
        self.backClock.delegate = self
        self.backClock.faceBackgroundColor = UIColor.clearColor()
        self.backClock.currentTime = true
        self.backClock.hourHandLength = self.view.frame.width*0.3
        self.backClock.minuteHandLength = self.view.frame.width*0.45
        self.backClock.secondHandLength = self.view.frame.width*0.5
        self.backClock.borderColor = UIColor.clearColor()
        
        self.backClock.realTime = true
        self.backClock.startRealTime()
        self.view.addSubview(self.backClock)
    }
    // Background Label and 4 digit clock displaying.
    func init_labels()
    {
        //Background big uilabel modeling.
        self.backMinLabel = UILabel(frame: CGRect(x: -40, y: bigDigitLabel_margin_y, width: wView+80, height: hView/2))
        self.backMinLabel.backgroundColor = UIColor.clearColor()
        self.backMinLabel.textAlignment = .Center
        self.backMinLabel.text = "59"
        self.backMinLabel.textColor = UIColor.whiteColor()
//        self.backMinLabel.font = UIFont.systemFontOfSize(300)
        self.backMinLabel.font = UIFont(name: "Helvetica-edit", size: backFontSizeBigDigitClockView)
        self.backMinLabel.font = UIFont.boldSystemFontOfSize(backFontSizeBigDigitClockView)
        self.backMinLabel.textColor = fstColor
        self.view.addSubview(self.backMinLabel)
        //Center point in the view
        let centerCircle: UIView = UIView(frame: CGRect(x: wView/2 - rCenterPoint/2, y: hView/2 - rCenterPoint/2, width: rCenterPoint, height: rCenterPoint))
        centerCircle.layer.borderColor = UIColor.redColor().CGColor
        centerCircle.layer.cornerRadius = rCenterPoint/2
        centerCircle.layer.masksToBounds = true
        centerCircle.layer.borderWidth = 1
        centerCircle.backgroundColor = UIColor.yellowColor()
        self.view.addSubview(centerCircle)
        //First Clock displaying
        let hClockView = rDotView + 2 + hourFontSizeBigDigitClockView + 2 + cityFontSizeBigDigitClockView + 2
        for index in 0..<self.hours.count
        {
            switch index {
            case 0:
                self.clockView = UIView(frame: CGRect(x: wView/2 - hourFontSizeBigDigitClockView * 1.5,
                                                      y: hView/2 - hClockView,
                                                  width: hourFontSizeBigDigitClockView * 1.5,
                                                 height: hClockView))
                self.clockView = self.dispItemInfo(self.clockView, index: index)
            case 1:
                self.clockView = UIView(frame: CGRect(x: wView/2,
                                                      y: hView/2 - hClockView,
                                                  width: hourFontSizeBigDigitClockView * 1.5,
                                                 height: hClockView))
                self.clockView = self.dispItemInfo(self.clockView, index: index)
            case 2:
                self.clockView = UIView(frame: CGRect(x: wView/2 - hourFontSizeBigDigitClockView * 1.5,
                                                      y: hView/2,
                                                  width: hourFontSizeBigDigitClockView * 1.5,
                                                 height: hClockView))
                self.clockView = self.dispItemInfo(self.clockView, index: index)
            case 3:
                self.clockView = UIView(frame: CGRect(x: wView/2,
                                                      y: hView/2,
                                                  width: hourFontSizeBigDigitClockView * 1.5,
                                                 height: hClockView))
                self.clockView = self.dispItemInfo(self.clockView, index: index)
            default:
                break
            }
            self.view.addSubview(self.clockView)
        }
        
        
        
        
        
    }
    func dispItemInfo(viewBody: UIView, index: Int) -> UIView
    {
        var hourLabel: UILabel!
        var cityLabel: UILabel!
        var dotView: UIView!
        //clock hour displaying
        switch index {
        case 2, 3:
            hourLabel = UILabel(frame: CGRect(x: 0,
                                              y: cityFontSizeBigDigitClockView + 2,
                                          width: viewBody.frame.size.width,
                                         height: hourFontSizeBigDigitClockView))
            
            cityLabel = UILabel(frame: CGRect(x: 0,
                                              y: rDotView,
                                          width: viewBody.frame.size.width,
                                         height: cityFontSizeBigDigitClockView))
            
            dotView = UIView(frame: CGRect(x: 0,
                                           y: cityFontSizeBigDigitClockView + 2 + hourFontSizeBigDigitClockView + 2,
                                       width: rDotView,
                                      height: rDotView))
        default:
            hourLabel = UILabel(frame: CGRect(x: 0,
                                              y: rDotView + 2,
                                          width: viewBody.frame.size.width,
                                         height: hourFontSizeBigDigitClockView))
            
            cityLabel = UILabel(frame: CGRect(x: 0,
                                              y: rDotView + 2 + hourFontSizeBigDigitClockView + 2,
                                          width: viewBody.frame.size.width,
                                         height: cityFontSizeBigDigitClockView))
            
            dotView = UIView(frame: CGRect(x: 0,
                                           y: 0,
                                       width: rDotView,
                                      height: rDotView))
        }
        
        
        hourLabel.textAlignment = .Center
        hourLabel.text = "\(self.hours[index])"
        hourLabel.font = UIFont(name: "Helvetica-edit.ttf", size: hourFontSizeBigDigitClockView)
        hourLabel.font = UIFont.boldSystemFontOfSize(hourFontSizeBigDigitClockView)
        hourLabel.textColor = secColor
        //City
        cityLabel.center.x = hourLabel.center.x
        cityLabel.textColor = UIColor.blackColor()
        cityLabel.textAlignment = .Center
        cityLabel.text = "\(self.cities[index])"
        cityLabel.font = UIFont(name: "Helvetica-edit", size: cityFontSizeBigDigitClockView)
        cityLabel.font = UIFont.boldSystemFontOfSize(cityFontSizeBigDigitClockView)
        //Dot View
        
        
        dotView.layer.cornerRadius = rDotView/2
        dotView.layer.masksToBounds = true
        dotView.backgroundColor = UIColor.blackColor()
        dotView.center.x = hourLabel.center.x
        
        
        viewBody.addSubview(dotView)
        viewBody.addSubview(hourLabel)
        viewBody.addSubview(cityLabel)
        return viewBody
    }


    func init_buttons()
    {
        self.btn_alarm = UIButton(frame: CGRect(x: wView * 0.25 - alarm_w/2,
            y: 8*hView/9 - alarm_h/2,
            width: alarm_w,
            height: alarm_h))
        
        let alarmOriginImg = UIImage(named: "multiClock_alarm_down@2x.png")
        let alarmTintedImg = alarmOriginImg?.imageWithRenderingMode(.AlwaysTemplate)
        self.btn_alarm.setImage(alarmTintedImg, forState: .Normal)
        self.btn_alarm.tintColor = alarmTintColor
        self.btn_alarm.addTarget(self, action: #selector(HomeClockVC.btn_alarm_tapped(_:)), forControlEvents: .TouchUpInside)
        
        self.btn_alarm.tag = 100
        self.view.addSubview(self.btn_alarm)
        
        self.btn_setting = UIButton(frame: CGRect(x: wView * 0.25 - setting_w/2, y: 7 * hView/9 - setting_h/2, width: setting_w, height: setting_h))
        let settingOriginImg = UIImage(named: "multiClock_info_down.png")
        let settingTintedImg = settingOriginImg?.imageWithRenderingMode(.AlwaysTemplate)
        self.btn_setting.setImage(settingTintedImg, forState: .Normal)
        self.btn_setting.tintColor = settingTintColor
        self.btn_setting.addTarget(self, action: #selector(HomeClockVC.btn_setting_tapped(_:)), forControlEvents: .TouchUpInside)
        self.btn_setting.tag = 101
        
        self.view.addSubview(self.btn_setting)
    }
    func btn_setting_tapped(sender:UIButton!)
    {
        let settingView = SettingTVC()
        self.navigationController?.pushViewController(settingView, animated: true)
    }
    func btn_alarm_tapped(sender: UIButton)
    {
        let alarmView = AlarmMainVC()
        self.navigationController?.pushViewController(alarmView, animated: true)
    }
}
extension BigDigitClockVC{
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
extension BigDigitClockVC: BEMAnalogClockDelegate{
    func analogClock(clock: BEMAnalogClockView!, graduationLengthForIndex index: Int) -> CGFloat {
        if index == 0{
            return 15
        }else if ((index % 5) == 0){
            return 10
        }else {
            return 3
        }
    }
    func analogClock(clock: BEMAnalogClockView!, graduationColorForIndex index: Int) -> UIColor! {
        return UIColor.clearColor()
    }
}

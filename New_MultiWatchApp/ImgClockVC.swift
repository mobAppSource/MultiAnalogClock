//
//  ImgClockVC.swift
//  multiWatchApp
//
//  Created by Master on 6/21/16.
//  Copyright © 2016 Master. All rights reserved.
//

import UIKit
import BEMAnalogClock

class ImgClockVC: UIViewController{

    
    var btn_alarm: UIButton!
    var btn_setting: UIButton!
    
    //
    var fstClockView: UIView!
    var secClockView: UIView!
    var thdClockView: UIView!
    var forClockView: UIView!
    var locClockView: UIView!
    
    // Init parameters for every countries time
    
//    var bkColors: [UIColor] = [UIColor.redColor(), UIColor.blueColor(), UIColor.yellowColor(), UIColor.greenColor(), UIColor.blackColor()]
    var bkColors: [UIColor] = [fstColor, fstColor, thdColor,thdColor,secColor]
    
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
        //view for setting and alarm view
        self.dispClockView(UIView(frame: CGRect(x: wView/2, y: 2 * hView/3, width: wView/2, height: hView/3)), index: 100)
        //Initialization of ClockViews
        self.init_imgClocks()
        //Initialization of alarm and setting buttons.
        self.init_buttons()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //ImgClockViews define.
    func init_imgClocks()
    {
        for index in 0..<hours.count
        {
            var clockView: UIView!
            switch index {
            case 0:
                clockView = UIView(frame: CGRect(x: 0, y: 0, width: wView/2, height: hView/3))
            case 1:
                clockView = UIView(frame: CGRect(x: wView/2, y: 0, width: wView/2, height: hView/3))
            case 2:
                clockView = UIView(frame: CGRect(x: 0, y: hView/3, width: wView/2, height: hView/3))
            case 3:
                clockView = UIView(frame: CGRect(x: wView/2, y: hView/3, width: wView/2, height: hView/3))
            default:
                clockView = UIView(frame: CGRect(x: 0, y: 2 * hView/3, width: wView/2, height: hView/3))
            }
            self.dispClockView(clockView, index: index)
            
            centerPoint(clockView)
            
        }
    }
    
    func dispClockView(viewBody: UIView, index: Int)
    {
//        viewBody.backgroundColor = UIColor.clearColor()
        
        viewBody.layer.borderColor = UIColor.blackColor().CGColor
        viewBody.layer.masksToBounds = true
        viewBody.layer.borderWidth = 0.5
        
        if index != 100{//Last area did not appear the clock,because it shows me the buttons
            
            let cityLabel: UILabel = UILabel(frame: CGRect(x: 5, y: 5, width: viewBody.frame.size.width, height: cityFontSizeBigDigitClockView))
            cityLabel.font = UIFont(name: "Helvetica-edit", size: cityFontSizeBigDigitClockView)
            cityLabel.font = UIFont.boldSystemFontOfSize(cityFontSizeBigDigitClockView)
            cityLabel.text = cities[index]
            viewBody.addSubview(cityLabel)
            viewBody.backgroundColor = self.bkColors[index]
            
            let wClock = viewBody.frame.width
//            let clockView = BEMAnalogClockView(frame: CGRect(x: 0, y: viewBody.frame.height/2 - wClock/2, width: wClock, height: wClock))
            let clockView = BEMAnalogClockView(frame: CGRect(x: -wClock/2, y: viewBody.frame.height/2 - wClock, width: 2*wClock, height: 2*wClock))
            clockView.faceBackgroundColor = UIColor.clearColor()
            clockView.delegate = self
            clockView.borderColor = UIColor.clearColor()
            clockView.hourHandOffsideLength = rCenterPoint/2
            clockView.hourHandLength = 2*wClock
            if index == 4{
                clockView.currentTime = true
                clockView.hourHandAlpha = 0
                clockView.minuteHandLength = 2*wClock
                clockView.secondHandLength = 2*wClock
                clockView.minuteHandOffsideLength = rCenterPoint/2
            }else{
                clockView.hours = hours[index]
                clockView.minuteHandColor = UIColor.clearColor()
                clockView.secondHandColor = UIColor.clearColor()
            }
            switch index {
            case 0,1:
                clockView.hourHandColor = secColor
            case 2,3:
                clockView.hourHandColor = fstColor
            case 4:
                clockView.minuteHandColor = thdColor
            default:
                clockView.hourHandColor =  UIColor.clearColor()
            }
            clockView.realTime = true
            clockView.startRealTime()
            
            viewBody.addSubview(clockView)
//            print("----------------- \(index) -----------------------")
//            print("City: \(self.cities[index])")
//            print("Hour: \(self.hours[index])")
//            print("Center: \(clockView.center)")
        }
        
        self.view.addSubview(viewBody)
//        print("View Size: \(viewBody.frame)")
    }
    //MARK: - Alarm, setting buttons define
    func init_buttons()
    {
        self.btn_alarm = UIButton(frame: CGRect(x: wView * 0.75 - alarm_w/2,
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
     
        self.btn_setting = UIButton(frame: CGRect(x: wView * 0.75 - setting_w/2, y: 7 * hView/9 - setting_h/2, width: setting_w, height: setting_h))
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ImgClockVC{
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
extension ImgClockVC: BEMAnalogClockDelegate{
    //Analog Clock scale color clearing
    func analogClock(clock: BEMAnalogClockView!, graduationColorForIndex index: Int) -> UIColor! {
        return UIColor.clearColor()
    }
    func analogClock(clock: BEMAnalogClockView!, graduationLengthForIndex index: Int) -> CGFloat {
        if index == 0{
            return 15
        }else if ((index % 5) == 0){
            return 10
        }else {
            return 3
        }
    }
}

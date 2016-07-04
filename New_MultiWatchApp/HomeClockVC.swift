//
//  HomeClockVC.swift
//  multiWatchApp
//
//  Created by Master on 6/21/16.
//  Copyright © 2016 Master. All rights reserved.
//

import UIKit
import BEMAnalogClock


class HomeClockVC: UIViewController, BEMAnalogClockDelegate {

    var clockView1: BEMAnalogClockView!
    var clockView2: BEMAnalogClockView!
    var clockView3: BEMAnalogClockView!
    var clockView4: BEMAnalogClockView!
    
    let dClock1: CGFloat = wView - 40
    var dClock2: CGFloat!
    var dClock3: CGFloat!
    var dClock4: CGFloat!
    var delta: CGFloat!
    
    
    var btn_alarm: UIButton!
    var btn_setting: UIButton!
    var isAlarmActive: Bool!
    var isSettingClicked:Bool!
    var wasTimeChanged: Bool = true
    var timer = NSTimer()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = thdColor
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame = UIScreen.mainScreen().bounds
        self.view.layer.cornerRadius = rCornerRadius
        self.view.layer.masksToBounds = true
        self.view.layer.borderColor = UIColor.whiteColor().CGColor        
        self.view.layer.borderWidth = 1
        
        //calculation of clock diameter
        self.delta = self.dClock1 / 8
        self.dClock4 = 2 * delta
        self.dClock3 = 4 * delta
        self.dClock2 = 6 * delta
        
        //Initialization of clockviews
        self.init_clocks()
        //initialization of buttons
        self.init_buttons()
        //Display the flacker dot view on the main view
        self.dispDotView(true)
        //using the NSTimer in swift
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(self.timeChanged), userInfo: nil, repeats: true)
        
    }
    //Setting up the timer function
    func timeChanged()
    {
        self.wasTimeChanged = !self.wasTimeChanged
        if self.wasTimeChanged{
            if let dotView = self.view.viewWithTag(500){
                dotView.backgroundColor = UIColor.whiteColor()
            }
        }else{
            if let dotView = self.view.viewWithTag(500){
                dotView.backgroundColor = bkColor
            }
        }
    }
    //displaying the 2 buttons
    func init_buttons()
    {
        self.isAlarmActive = false
        self.btn_alarm = UIButton(frame: CGRect(x: alarm_margin_x + setting_margin_x - alarm_w/2,
                                                y: hView - setting_margin_y - alarm_h/2,
                                            width: alarm_w,
                                           height: alarm_h))
        
        let alarmOriginImg = UIImage(named: "multiClock_alarm_down@2x.png")
        let alarmTintedImg = alarmOriginImg?.imageWithRenderingMode(.AlwaysTemplate)
        self.btn_alarm.setImage(alarmTintedImg, forState: .Normal)
        self.btn_alarm.tintColor = alarmTintColor
        self.btn_alarm.addTarget(self, action: #selector(HomeClockVC.btn_alarm_tapped(_:)), forControlEvents: .TouchUpInside)
        
        self.btn_alarm.tag = 100
        self.view.addSubview(self.btn_alarm)
        
        self .isSettingClicked = false
        self.btn_setting = UIButton(frame: CGRect(x: alarm_margin_x - setting_w/2, y: hView - alarm_margin_y - setting_h/2, width: setting_w, height: setting_h))
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
    //Displaying the 4 clocks
    func init_clocks()
    {
        self.clockView1 = BEMAnalogClockView(frame: CGRect(x: 20, y: hView/2 - self.dClock1/2, width: self.dClock1, height: self.dClock1))
        self.clockView1.layer.cornerRadius = self.dClock1/2
        self.clockView1.layer.masksToBounds = true
        self.clockView1.layer.borderWidth = 2
        self.clockView1.layer.borderColor = UIColor.blueColor().CGColor
        self.clockView1.backgroundColor = UIColor.whiteColor()
        //Define clock properties
        self.clockView1.delegate = self
        self.clockView1.hourHandLength = self.clockView1.frame.size.width*0.5
        self.clockView1.minuteHandLength = self.clockView1.frame.size.width*0.5
        self.clockView1.minuteHandAlpha = 1
        self.clockView1.secondHandAlpha = 0
        self.clockView1.hourHandOffsideLength = 0
        self.clockView1.hours = 5
        self.clockView1.minutes = 15
        self.clockView1.realTime = true
        self.clockView1.startRealTime()
        self.clockView1.faceBackgroundColor = secColor
        self.clockView1.minuteHandColor = thdColor
        self.clockView1.hourHandColor = thdColor
        self.clockView1.borderColor = UIColor.clearColor()
        
        //adding city name
        var cityName: UILabel = UILabel(frame: CGRect(x: self.clockView1.frame.size.width/2 - 20, y: 10, width: 40, height: 20))
        cityName.text = cities[0]
        cityName.backgroundColor = UIColor.clearColor()
        cityName.textColor = thdColor
        cityName.textAlignment = .Center
        cityName.font = UIFont.boldSystemFontOfSize(17)
        self.clockView1.addSubview(cityName)
        
        self.view.addSubview(self.clockView1)
        
        self.clockView2 = BEMAnalogClockView(frame: CGRect(x: 20 + self.delta, y: hView/2 - self.dClock2/2, width: self.dClock2, height: self.dClock2))
        self.clockView2.layer.cornerRadius = self.dClock2/2
        self.clockView2.layer.masksToBounds = true
        self.clockView2.layer.borderWidth = 2
        self.clockView2.layer.borderColor = UIColor.blueColor().CGColor
        self.clockView2.backgroundColor = UIColor.whiteColor()
        //Define clock properties
        self.clockView2.delegate = self
        self.clockView2.minuteHandLength = self.clockView2.frame.size.width*0.5
        self.clockView2.hourHandLength = self.clockView2.frame.size.width*0.5
        self.clockView2.minuteHandAlpha = 1
        self.clockView2.secondHandAlpha = 0
        self.clockView2.hourHandOffsideLength = 0
        self.clockView2.hours = 10
        self.clockView2.minutes = 15
        self.clockView2.realTime = true
        self.clockView2.startRealTime()
        self.clockView2.minuteHandColor = secColor
        self.clockView2.hourHandColor = secColor
        self.clockView2.faceBackgroundColor = thdColor
        self.clockView2.borderColor = UIColor.clearColor()
        
        //adding city name
        cityName = UILabel(frame: CGRect(x: self.clockView2.frame.size.width/2 - 20, y: 10, width: 40, height: 20))
        cityName.text = cities[1]
        cityName.backgroundColor = UIColor.clearColor()
        cityName.textColor = secColor
        cityName.textAlignment = .Center
        cityName.font = UIFont.boldSystemFontOfSize(17)
        self.clockView2.addSubview(cityName)
        
        self.view.addSubview(self.clockView2)
        
        self.clockView3 = BEMAnalogClockView(frame: CGRect(x: 20 + self.delta * 2, y: hView/2 - self.dClock3/2, width: self.dClock3, height: self.dClock3))
        self.clockView3.layer.cornerRadius = self.dClock3/2
        self.clockView3.layer.masksToBounds = true
        self.clockView3.layer.borderWidth = 2
        self.clockView3.layer.borderColor = UIColor.blueColor().CGColor
        self.clockView3.backgroundColor = UIColor.whiteColor()
        //Define clock properties
        self.clockView3.delegate = self
        self.clockView3.hourHandLength = self.clockView3.frame.size.width*0.5
        self.clockView3.minuteHandLength = self.clockView3.frame.size.width*0.5
        self.clockView3.minuteHandAlpha = 1
        self.clockView3.secondHandAlpha = 0
        self.clockView3.hourHandOffsideLength = 0
        self.clockView3.hours = 3
        self.clockView3.minutes = 15
        self.clockView3.realTime = true
        self.clockView3.startRealTime()
        self.clockView3.minuteHandColor = thdColor
        self.clockView3.hourHandColor = thdColor
        self.clockView3.faceBackgroundColor = secColor
        self.clockView3.borderColor = UIColor.clearColor()
        
        //adding city name
        cityName = UILabel(frame: CGRect(x: self.clockView3.frame.size.width/2 - 20, y: 10, width: 40, height: 20))
        cityName.text = cities[2]
        cityName.backgroundColor = UIColor.clearColor()
        cityName.textColor = thdColor
        cityName.textAlignment = .Center
        cityName.font = UIFont.boldSystemFontOfSize(17)
        self.clockView3.addSubview(cityName)
        
        self.view.addSubview(self.clockView3)
        
        self.clockView4 = BEMAnalogClockView(frame: CGRect(x: 20 + self.delta * 3, y: hView/2 - self.dClock4/2, width: self.dClock4, height: self.dClock4))
        
        self.clockView4.faceBackgroundColor = thdColor
        self.clockView4.borderColor = UIColor.clearColor()
        self.clockView4.layer.cornerRadius = self.dClock4/2
        self.clockView4.layer.borderWidth = 2
        self.clockView4.layer.borderColor = UIColor.blueColor().CGColor
        self.clockView4.backgroundColor = UIColor.clearColor()
        //Define clock properties
        self.clockView4.delegate = self
        self.clockView4.hours = 12
        self.clockView4.hourHandLength = self.clockView4.frame.size.width*0.5
        self.clockView4.hourHandColor = secColor
        self.clockView4.hourHandOffsideLength = 0
        self.clockView4.minutes = 15
        self.clockView4.minuteHandLength = self.dClock1*0.5
        self.clockView4.minuteHandOffsideLength = 0
        self.clockView4.minuteHandColor = secColor
        self.clockView4.secondHandAlpha = 1
        self.clockView4.secondHandOffsideLength = 0
        
        
        self.clockView4.realTime = true
        self.clockView4.startRealTime()
        
        //adding city name
        cityName = UILabel(frame: CGRect(x: self.clockView4.frame.size.width/2 - 20, y: 10, width: 40, height: 20))
        cityName.text = cities[3]
        cityName.backgroundColor = UIColor.clearColor()
        cityName.textColor = secColor
        cityName.textAlignment = .Center
        cityName.font = UIFont.boldSystemFontOfSize(17)
        self.clockView4.addSubview(cityName)
        
        self.view.addSubview(self.clockView4)
        print("W:H = \(wView):\(hView)")
    }
    func dispDotView(isShow: Bool)
    {
        let dotView = UIView(frame: CGRect(x: wView - (wView - self.dClock1)/2 - 2 * rDotView,
                                           y: (hView - self.dClock1)/2,
                                       width: 2 * rDotView,
                                      height: 2 * rDotView))
        dotView.layer.cornerRadius = rDotView
        dotView.layer.masksToBounds = true
        dotView.tag = 500
        if isShow{
            dotView.backgroundColor = UIColor.whiteColor()
        }else{
            dotView.backgroundColor = bkColor
        }
        self.view.addSubview(dotView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func analogClock(clock: BEMAnalogClockView!, graduationColorForIndex index: Int) -> UIColor! {
        return UIColor.clearColor()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}

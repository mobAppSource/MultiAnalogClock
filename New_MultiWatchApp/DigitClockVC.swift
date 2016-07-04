//
//  DigitClockVC.swift
//  multiWatchApp
//
//  Created by Master on 6/21/16.
//  Copyright © 2016 Master. All rights reserved.
//

import UIKit
import BEMAnalogClock

class DigitClockVC: UIViewController {

    var backClockView: BEMAnalogClockView!
//    var clockView: UIView!
    var clockView: BEMAnalogClockView!
    var btn_alarm: UIButton!
    var btn_setting: UIButton!
    
    // Init parameters for every countries time
    
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
        
        //Background analog clock
        self.viewBackClock()
        //DigitClockView initialization
        self.init_clockView()
        //Alarm, Setting view initialization
        self.init_buttons()
        
    }
    func viewBackClock()
    {
//        self.backClockView = BEMAnalogClockView(frame: CGRect(x: 0, y: 0, width: wView, height: wView))
        self.backClockView = BEMAnalogClockView(frame: CGRect(x: -100, y: -100, width: wView + 200, height: wView + 200))
        self.backClockView.delegate = self
        self.backClockView.realTime = true
        self.backClockView.startRealTime()
        self.backClockView.faceBackgroundColor = UIColor.clearColor()
        self.backClockView.borderColor = UIColor.clearColor()
        self.backClockView.minuteHandLength = wView
        self.backClockView.hourHandAlpha = 0
        self.backClockView.secondHandLength = wView
        
        self.view.addSubview(self.backClockView)
        //mask view for trimming the minute hand length
        let maskView = UIView(frame: CGRect(x: 40, y: 40, width: wView - 80, height: wView - 80))
        maskView.layer.masksToBounds = true
        maskView.backgroundColor = UIColor.clearColor()
        self.view.addSubview(maskView)
    }
    
    func init_clockView()
    {
        for index in 0..<hours.count-1
        {
            var clockView: UIView!
            switch index {
            case 0:
                clockView = UIView(frame: CGRect(x: 0, y: 0, width: wView/2, height: wView/2))
            case 1:
                clockView = UIView(frame: CGRect(x: wView/2, y: 0, width: wView/2, height: wView/2))
            case 2:
                clockView = UIView(frame: CGRect(x: 0, y: wView/2, width: wView/2, height: wView/2))
            case 3:
                clockView = UIView(frame: CGRect(x: wView/2, y: wView/2, width: wView/2, height: wView/2))
            default:
                clockView = UIView(frame: CGRect(x: 0, y: wView/2, width: wView/2, height: wView/2))
            }
            self.dispClockInfo(clockView, index: index)
        }
    }
    
    func dispClockInfo(viewBody: UIView, index: Int){
        var cityLabel: UILabel!
        var dotView: UIView!
        let hourLabel: UILabel = UILabel(frame: CGRect(x: viewBody.frame.size.width/2 - hourFontSizeBigDigitClockView/2,
                                                       y: viewBody.frame.size.height/2 - hourFontSizeBigDigitClockView/2,
                                                   width: hourFontSizeBigDigitClockView * 1.5,
                                                  height: hourFontSizeBigDigitClockView))
        switch index {
        case 0:
            cityLabel = UILabel(frame: CGRect(x: 5,
                                              y: 5,
                                          width: viewBody.frame.size.width,
                                         height: cityFontSizeBigDigitClockView))
            cityLabel.textAlignment = .Left
        case 1:
            cityLabel = UILabel(frame: CGRect(x: 5,
                                              y: 5,
                                          width: viewBody.frame.size.width - 10,
                                         height: cityFontSizeBigDigitClockView))
            cityLabel.textAlignment = .Right
        case 2:
            cityLabel = UILabel(frame: CGRect(x: 5,
                                              y: viewBody.frame.size.height - cityFontSizeBigDigitClockView - 5,
                                          width: viewBody.frame.size.width,
                                         height: cityFontSizeBigDigitClockView))
            cityLabel.textAlignment = .Left
        case 3:
            cityLabel = UILabel(frame: CGRect(x: 5,
                                              y: viewBody.frame.size.height - cityFontSizeBigDigitClockView - 5,
                                          width: viewBody.frame.size.width-10,
                                         height: cityFontSizeBigDigitClockView))
            cityLabel.textAlignment = .Right
        default:
            break
        }
        dotView = UIView(frame: CGRect(x: viewBody.frame.size.width/2 - rDotView/2,
                                       y: viewBody.frame.size.height/2,
                                   width: rDotView,
                                  height: rDotView))
        
        cityLabel.font = UIFont(name: "Helvetica-edit.tff", size: cityFontSizeBigDigitClockView)
        cityLabel.font = UIFont.boldSystemFontOfSize(cityFontSizeBigDigitClockView)
        cityLabel.text = cities[index]

        print("Time: \(getTimeFromCityName(city_normal_Name[index]))")
        hourLabel.center = CGPoint(x: viewBody.frame.size.width/2, y: viewBody.frame.size.height/2)
        hourLabel.font = UIFont(name: "Helvetica-edit.tff", size: hourFontSizeBigDigitClockView)
        hourLabel.font = UIFont.boldSystemFontOfSize(hourFontSizeBigDigitClockView)
        hourLabel.text = "\(hours[index])"
        hourLabel.textAlignment = .Center
        hourLabel.textColor = secColor
        
        dotView.center = CGPoint(x: hourLabel.center.x , y: hourLabel.center.y + hourFontSizeBigDigitClockView/2)
        switch index {
        case 0,1:
            dotView.center = CGPoint(x: hourLabel.center.x , y: hourLabel.center.y + hourFontSizeBigDigitClockView/2)
        case 2,3:
            dotView.center = CGPoint(x: hourLabel.center.x , y: hourLabel.center.y - hourFontSizeBigDigitClockView/2)
        default:
            break
        }
        
        dotView.layer.cornerRadius = rDotView/2
        dotView.layer.masksToBounds = true
        dotView.backgroundColor = UIColor.whiteColor()
        
        viewBody.addSubview(dotView)
        viewBody.addSubview(hourLabel)
        viewBody.addSubview(cityLabel)
//        viewBody.layer.borderWidth = 1
//        viewBody.layer.borderColor = UIColor.whiteColor().CGColor
//        viewBody.layer.masksToBounds = true
        viewBody.backgroundColor = UIColor.clearColor()
        self.view.addSubview(viewBody)
    }
    
    func init_buttons() {
        self.btn_alarm = UIButton(frame: CGRect(x: alarm_margin_x + setting_margin_x - alarm_w/2, y: hView - setting_margin_y - alarm_h/2, width: alarm_w, height: alarm_h))
        let alarmOriginImg = UIImage(named: "multiClock_alarm_down@2x.png")
        let alarmTintedImg = alarmOriginImg?.imageWithRenderingMode(.AlwaysTemplate)
        self.btn_alarm.setImage(alarmTintedImg, forState: .Normal)
        self.btn_alarm.tintColor = alarmTintColor
        self.btn_alarm.addTarget(self, action: #selector(DigitClockVC.btn_alarm_tapped(_:)), forControlEvents: .TouchUpInside)
        
        self.btn_setting = UIButton(frame: CGRect(x: alarm_margin_x - setting_w/2, y: hView - alarm_margin_y - setting_h/2, width: setting_w, height: setting_h))
        let settingOriginImg = UIImage(named: "multiClock_info_down.png")
        let settingTintedImg = settingOriginImg?.imageWithRenderingMode(.AlwaysTemplate)
        self.btn_setting.setImage(settingTintedImg, forState: .Normal)
        self.btn_setting.tintColor = settingTintColor
        self.btn_setting.addTarget(self, action: #selector(DigitClockVC.btn_setting_tapped(_:)), forControlEvents: .TouchUpInside)
        
        
        self.view.addSubview(self.btn_setting)
        self.view.addSubview(self.btn_alarm)
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
extension DigitClockVC{
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
//BEMAanalogClock Delegate
extension DigitClockVC: BEMAnalogClockDelegate{
    //Analog Clock scale color clearing
    func analogClock(clock: BEMAnalogClockView!, graduationColorForIndex index: Int) -> UIColor! {
        return UIColor.clearColor()
    }
}

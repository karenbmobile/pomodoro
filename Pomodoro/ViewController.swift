//
//  ViewController.swift
//  Pomodoro
//
//  Created by Karen Brown on 21/09/17.
//  Copyright © 2017 TWL Software. All rights reserved.
//

import UIKit
import AVFoundation
import UserNotifications

class ViewController: UIViewController {
    
    var timer = Timer()
    
    //set the pomodoro and break times
    let pomodoro: Double = 30  //change back to 1500 after testing
    let shortBreak: Double = 300
    let longBreak: Double = 1200
    
    var timeToFinish: NSDate = NSDate()
    
    @IBOutlet weak var countdownView: UILabel!
    
    @IBAction func stopButton(_ sender: Any) {
        //stop the timer
        timer.invalidate()
        
        //remove notification when cancelled
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
    }
    
    
    
     @objc func displayTheCountdown() {
        // get the time between the timeToFinish and current time
        let currentDate = NSDate()
        let timeRemaining = timeToFinish.timeIntervalSince(currentDate as Date)
        
        if timeRemaining / 60 <= 0 {
            countdownView.text = "Done"
            timer.invalidate()
        } else {
            //format remaining time and display
            var minute: Int {
                return Int(timeRemaining/60)
            }
        
            var second: Int {
                return Int(Int(timeRemaining) % 60)
            }
            countdownView.text = String(format:"%d:%02d", minute, second)

        }
    }
    
    func setAlarmAndDisplay(alarmType: String, seconds: Double) {
        
        switch (alarmType) {
        case ("Short Break"):
            timeToFinish = NSDate.init(timeIntervalSinceNow: shortBreak)
        case ("Long Break"):
            timeToFinish = NSDate.init(timeIntervalSinceNow: longBreak)
        default: //pomodoro
            timeToFinish = NSDate.init(timeIntervalSinceNow: pomodoro)
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(displayTheCountdown), userInfo: nil, repeats: true)
        
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = alarmType + " done"
        
        if alarmType == "Pomodoro" {
            content.body = "break time!"
        } else {
            content.body = "back to work!"
        }
        
        content.sound = UNNotificationSound.default()
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        
        let identifier = "UYLLocalNotification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        center.add(request, withCompletionHandler: { (error) in
            if let error = error {
                print("there was an error: " + error.localizedDescription)
            }
        })
    }
    
    

    
    @IBAction func startPomodoro(_ sender: Any) {
        //set a timer for a pomodoro length (default = 25min)
        setAlarmAndDisplay(alarmType: "Pomodoro", seconds: pomodoro)
    }
    
    @IBAction func startShortBreak(_ sender: Any) {
        setAlarmAndDisplay(alarmType: "Short Break", seconds: shortBreak)

    }
    
    @IBAction func startLongBreak(_ sender: Any) {
        setAlarmAndDisplay(alarmType: "Long Break", seconds: longBreak)

    }
    
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        countdownView.layer.cornerRadius = 100;
        countdownView.clipsToBounds = true;
        
        
        
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


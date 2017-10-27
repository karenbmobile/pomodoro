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
    
    //set the controls for what label to display
    //var timerRunning = false
    var pomodoroCount = 0
    
    @IBOutlet weak var countdownView: UILabel!
    @IBOutlet weak var activeTaskLabel: UILabel!
    
    
    @IBAction func bigRedTimerButton(_ sender: Any) {
        //let the user tap the red area to start and stop the timer
        //is dependent on fillTimerLabel() working correctly
        switch countdownView.text {
        case ("Pomodoro"?):
            setAlarmAndDisplay(alarmType: "Pomodoro", seconds: pomodoro)
        case ("Short Break"?):
            setAlarmAndDisplay(alarmType: "Short Break", seconds: shortBreak)
        case ("Long Break"?):
            setAlarmAndDisplay(alarmType: "Long Break", seconds: longBreak)
        default:
            //stop the timer and cancel the notification
            timer.invalidate()
            let center = UNUserNotificationCenter.current()
            center.removeAllPendingNotificationRequests()
        }
        
    }
    
    
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
            if let info = timer.userInfo as? String {
                if info == "Short Break" || info == "Long Break" {
                    countdownView.font = countdownView.font.withSize(36)
                    countdownView.text = "Pomodoro"
                }
                else if pomodoroCount % 4 == 0 {
                    countdownView.font = countdownView.font.withSize(34)
                    countdownView.text = "Long Break"
                }
                else {
                    countdownView.font = countdownView.font.withSize(34)
                    countdownView.text = "Short Break"
                }
            }
            
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
            pomodoroCount += 1
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(displayTheCountdown), userInfo: alarmType, repeats: true)
 

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


//
//  ViewController.swift
//  BlinkSDK
//
//  Created by AbdulrahmanAlaa114 on 07/26/2024.
//  Copyright (c) 2024 AbdulrahmanAlaa114. All rights reserved.
//

import UIKit
import CoreLocation
import BlinkSDK

class ViewController: UIViewController {

    var tripStarted = false
    var counter = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBlinkObservers()
    }

    func setupBlinkObservers() {
        Blink.shared.addTripStatusObserver(self)
        Blink.shared.addTripTrackingObserver(self)
        Blink.shared.addAccidentDetectionObserver(self)
        Blink.shared.addDriverBehaviorObserver(self)
    }
    
    @IBAction func startOrEndTripButton(_ sender: UIButton) {
        tripStarted.toggle()
        Blink.shared.startTripManually(startTrip: tripStarted)
        let titile = tripStarted ? "End Trip" : "Start Trip"
        sender.setTitle(titile, for: .normal)
    }

}

extension ViewController: DriverBehaviorObserver {
    func didEncounterIncident(_ incidentType: IncidentType, severityLevel: Int) {
        DispatchQueue.main.async { [weak self] in
            self?.scheduleNotification(body: "did Encounter Incident.")
        }
    }
}

extension ViewController: AccidentDetectionObserver {
    
    func didDetectAccident(severity: Int32, speed: Double) {
        DispatchQueue.main.async { [weak self] in
            self?.scheduleNotification(body: "did Detect Accident.")
        }
    }
}

extension ViewController: TripStatusObserver {
    func didStartTrip(at location: CLLocation) {
        DispatchQueue.main.async { [weak self] in
            self?.setDate(string: "StartTrip \(Date())")
            self?.scheduleNotification(body: "Trip has started.")
        }
        
    }
    
    func didEndTrip(at location: CLLocation) {
        DispatchQueue.main.async { [weak self] in
            self?.setDate(string: "EndTrip \(Date())")
            self?.scheduleNotification(body: "Trip has ended.")
        }
    }
}

extension ViewController: TripTrackingObserver {
   
    
    func didUpdateLocation(_ location: CLLocation) {
        if counter >= 60  {
            counter = 0
        } else if counter == 0 {
            setDate(string: "UpdateLocation \(Date())")
            counter += 1
        }
        
    }
    
    func setDate(string: String) {
        var array = (UserDefaults.standard.array(forKey: "TestTrip") as? [String]) ?? []
        array.append(string)
        UserDefaults.standard.setValue(array, forKey: "TestTrip")
    }
}


extension ViewController {
    
    func scheduleNotification(body: String) {
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = body
        content.sound = .default()
        
        // Create a trigger that fires after the specified time interval
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        // Create a request with a unique identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        // Schedule the notification
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled to fire in \(1) seconds.")
            }
        }
    }
}

//
//  MainViewController.swift
//  SevenPlusH
//
//  Created by Shardul Joshi on 7/31/18.
//  Copyright © 2018 N/A. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    // Placeholders for class info
    // Classes
    var aBlock = "A-Block"
    var bBlock = "B-Block"
    var cBlock = "C-Block"
    var dBlock = "D-Block"
    var eBlock = "E-Block"
    var fBlock = "F-Block"
    var gBlock = "G-Block"
    var hBlock = "H-Block"
    // Teachers
    var aTeach = "A-Teach"
    var bTeach = "B-Teach"
    var cTeach = "C-Teach"
    var dTeach = "D-Teach"
    var eTeach = "E-Teach"
    var fTeach = "F-Teach"
    var gTeach = "G-Teach"
    var hTeach = "H-Teach"
    // Rooms
    var aRoom = "A-Room"
    var bRoom = "B-Room"
    var cRoom = "C-Room"
    var dRoom = "D-Room"
    var eRoom = "E-Room"
    var fRoom = "F-Room"
    var gRoom = "G-Room"
    var hRoom = "H-Room"
    // Lunches
    var aLunch = "Lunch 0"
    var bLunch = "Lunch 0"
    var cLunch = "Lunch 0"
    var dLunch = "Lunch 0"
    var eLunch = "Lunch 0"
    var fLunch = "Lunch 0"
    var gLunch = "Lunch 0"
    var hLunch = "Lunch 0"
    
    // Colors for color coding the blocks
    var aBlockColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1)
    var bBlockColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
    var cBlockColor = UIColor(red: 255/255, green: 147/255, blue: 0/255, alpha: 1)
    var dBlockColor = UIColor(red: 0/255, green: 150/255, blue: 255/255, alpha: 1)
    var eBlockColor = UIColor(red: 253/255, green: 216/255, blue: 53/255, alpha: 1)
    var fBlockColor = UIColor(red: 79/255, green: 143/255, blue: 0/255, alpha: 1)
    var gBlockColor = UIColor(red: 255/255, green: 138/255, blue: 216/255, alpha: 1)
    var hBlockColor = UIColor(red: 255/255, green: 38/255, blue: 0/255, alpha: 1)
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateUI()
    }
    
    // If first launch, app will display instructions view. Otherwise, fills in schedule information variables with saved data
    func updateUI() {
        // Determines which semester to use
        var currentSemester = "1"
        let dateA = NSDate()
        var dateComponents = DateComponents()
        dateComponents.year = 2019
        dateComponents.month = 1
        dateComponents.day = 24
        dateComponents.timeZone = TimeZone(abbreviation: "EST")
        dateComponents.hour = 0
        dateComponents.minute = 0
        let userCalendar = Calendar.current
        let dateB = userCalendar.date(from: dateComponents)
        switch dateA.compare(dateB!) {
            case .orderedAscending     :   currentSemester = "1"
            case .orderedDescending    :   currentSemester = "2"
            case .orderedSame          :   currentSemester = "1"
        }
        let file = "semester" + currentSemester + ".txt"
        var text = ""
        if !isAppAlreadyLaunchedOnce() {
            if let dir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
                let fileURL = dir.appendingPathComponent(file)
                do {
                    for c in UnicodeScalar("A").value...UnicodeScalar("H").value {
                        text += String(UnicodeScalar(c)!) + "-Block\n" + String(UnicodeScalar(c)!) + "-Teach\n" + String(UnicodeScalar(c)!) + "-Room\nLunch 0\n"
                    }
                    try text.write(to: fileURL, atomically: false, encoding: .utf8)
                }
                catch {print("Error")}
            }
            performSegue(withIdentifier: "getInstructions", sender: nil)
        } else {
            if let dir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
                let fileURL = dir.appendingPathComponent(file)
                do {
                    text = try String(contentsOf: fileURL, encoding: .utf8)
                    let schedule = text.components(separatedBy: .newlines)
                    if schedule.count > 1 {
                        aBlock = schedule[0]
                        aTeach = schedule[1]
                        aRoom = schedule[2]
                        aLunch = schedule[3]
                        bBlock = schedule[4]
                        bTeach = schedule[5]
                        bRoom = schedule[6]
                        bLunch = schedule[7]
                        cBlock = schedule[8]
                        cTeach = schedule[9]
                        cRoom = schedule[10]
                        cLunch = schedule[11]
                        dBlock = schedule[12]
                        dTeach = schedule[13]
                        dRoom = schedule[14]
                        dLunch = schedule[15]
                        eBlock = schedule[16]
                        eTeach = schedule[17]
                        eRoom = schedule[18]
                        eLunch = schedule[19]
                        fBlock = schedule[20]
                        fTeach = schedule[21]
                        fRoom = schedule[22]
                        fLunch = schedule[23]
                        gBlock = schedule[24]
                        gTeach = schedule[25]
                        gRoom = schedule[26]
                        gLunch = schedule[27]
                        hBlock = "H-BLOCK"
                        hTeach = schedule[29]
                        hRoom = schedule[30]
                        hLunch = schedule[31]
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
    
    // Checks to see if app has been launched previously
    func isAppAlreadyLaunchedOnce()->Bool{
        let defaults = UserDefaults.standard
        if defaults.string(forKey: "isAppAlreadyLaunchedOnce") != nil{
            return true
        } else {
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            return false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    enum ButtonType: Int {
        case dayOne = 0, dayTwo, dayThree, dayFour, dayFive, daySix, daySeven, dayEight
    }
    
    // Brings user to Apen login page using web view in AspenViewController to allow them to update saved schedule information
    @IBAction func updateSchedule(_ sender: Any) {
        performSegue(withIdentifier: "aspenLogin", sender: nil)
    }
    
    // Shows user same instructions page as was displayed on first startup
    @IBAction func getInstructions(_ sender: Any) {
        performSegue(withIdentifier: "getInstructions", sender: nil)
    }
    
    // Sends which day was chosen to next view controller depending on which button was pressed
    @IBAction func showMySchedule(_ sender: Any) {
        switch(ButtonType(rawValue: (sender as AnyObject).tag)!) {
            case .dayOne:
                performSegue(withIdentifier: "showSchedule", sender: "1")
            case .dayTwo:
                performSegue(withIdentifier: "showSchedule", sender: "2")
            case .dayThree:
                performSegue(withIdentifier: "showSchedule", sender: "3")
            case .dayFour:
                performSegue(withIdentifier: "showSchedule", sender: "4")
            case .dayFive:
                performSegue(withIdentifier: "showSchedule", sender: "5")
            case .daySix:
                performSegue(withIdentifier: "showSchedule", sender: "6")
            case .daySeven:
                performSegue(withIdentifier: "showSchedule", sender: "7")
            case .dayEight:
                performSegue(withIdentifier: "showSchedule", sender: "8")
        }
    }
    
    // Fills in schedule table in the schedule view controller with correct schedule elements depending on number received from sender
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSchedule" {
            let showScheduleVC = segue.destination as! ScheduleViewController
            let day = sender as! String
            showScheduleVC.day = day
            if day == "1" {
                showScheduleVC.blockOne = aBlock
                showScheduleVC.blockTwo = cBlock
                showScheduleVC.blockThree = hBlock
                showScheduleVC.blockFour = eBlock
                showScheduleVC.lunchNumber = eLunch
                showScheduleVC.blockFive = gBlock
                showScheduleVC.blockOneColor = aBlockColor
                showScheduleVC.blockTwoColor = cBlockColor
                showScheduleVC.blockThreeColor = hBlockColor
                showScheduleVC.blockFourColor = eBlockColor
                showScheduleVC.blockFiveColor = gBlockColor
                showScheduleVC.blockOneTeach = aTeach
                showScheduleVC.blockTwoTeach = cTeach
                showScheduleVC.blockThreeTeach = hTeach
                showScheduleVC.blockFourTeach = eTeach
                showScheduleVC.blockFiveTeach = gTeach
                showScheduleVC.blockOneRoom = aRoom
                showScheduleVC.blockTwoRoom = cRoom
                showScheduleVC.blockThreeRoom = hRoom
                showScheduleVC.blockFourRoom = eRoom
                showScheduleVC.blockFiveRoom = gRoom
            } else if day == "2" {
                showScheduleVC.blockOne = bBlock
                showScheduleVC.blockTwo = dBlock
                showScheduleVC.blockThree = fBlock
                showScheduleVC.blockFour = gBlock
                showScheduleVC.lunchNumber = gLunch
                showScheduleVC.blockFive = eBlock
                showScheduleVC.blockOneColor = bBlockColor
                showScheduleVC.blockTwoColor = dBlockColor
                showScheduleVC.blockThreeColor = fBlockColor
                showScheduleVC.blockFourColor = gBlockColor
                showScheduleVC.blockFiveColor = eBlockColor
                showScheduleVC.blockOneTeach = bTeach
                showScheduleVC.blockTwoTeach = dTeach
                showScheduleVC.blockThreeTeach = fTeach
                showScheduleVC.blockFourTeach = gTeach
                showScheduleVC.blockFiveTeach = eTeach
                showScheduleVC.blockOneRoom = bRoom
                showScheduleVC.blockTwoRoom = dRoom
                showScheduleVC.blockThreeRoom = fRoom
                showScheduleVC.blockFourRoom = gRoom
                showScheduleVC.blockFiveRoom = eRoom
            } else if day == "3" {
                showScheduleVC.blockOne = aBlock
                showScheduleVC.blockTwo = hBlock
                showScheduleVC.blockThree = dBlock
                showScheduleVC.blockFour = cBlock
                showScheduleVC.lunchNumber = cLunch
                showScheduleVC.blockFive = fBlock
                showScheduleVC.blockOneColor = aBlockColor
                showScheduleVC.blockTwoColor = hBlockColor
                showScheduleVC.blockThreeColor = dBlockColor
                showScheduleVC.blockFourColor = cBlockColor
                showScheduleVC.blockFiveColor = fBlockColor
                showScheduleVC.blockOneTeach = aTeach
                showScheduleVC.blockTwoTeach = hTeach
                showScheduleVC.blockThreeTeach = dTeach
                showScheduleVC.blockFourTeach = cTeach
                showScheduleVC.blockFiveTeach = fTeach
                showScheduleVC.blockOneRoom = aRoom
                showScheduleVC.blockTwoRoom = hRoom
                showScheduleVC.blockThreeRoom = dRoom
                showScheduleVC.blockFourRoom = cRoom
                showScheduleVC.blockFiveRoom = fRoom
            } else if day == "4" {
                showScheduleVC.blockOne = bBlock
                showScheduleVC.blockTwo = aBlock
                showScheduleVC.blockThree = hBlock
                showScheduleVC.blockFour = gBlock
                showScheduleVC.lunchNumber = gLunch
                showScheduleVC.blockFive = eBlock
                showScheduleVC.blockOneColor = bBlockColor
                showScheduleVC.blockTwoColor = aBlockColor
                showScheduleVC.blockThreeColor = hBlockColor
                showScheduleVC.blockFourColor = gBlockColor
                showScheduleVC.blockFiveColor = eBlockColor
                showScheduleVC.blockOneTeach = bTeach
                showScheduleVC.blockTwoTeach = aTeach
                showScheduleVC.blockThreeTeach = hTeach
                showScheduleVC.blockFourTeach = gTeach
                showScheduleVC.blockFiveTeach = eTeach
                showScheduleVC.blockOneRoom = bRoom
                showScheduleVC.blockTwoRoom = aRoom
                showScheduleVC.blockThreeRoom = hRoom
                showScheduleVC.blockFourRoom = gRoom
                showScheduleVC.blockFiveRoom = eRoom
            } else if day == "5" {
                showScheduleVC.blockOne = cBlock
                showScheduleVC.blockTwo = bBlock
                showScheduleVC.blockThree = fBlock
                showScheduleVC.blockFour = dBlock
                showScheduleVC.lunchNumber = dLunch
                showScheduleVC.blockFive = gBlock
                showScheduleVC.blockOneColor = cBlockColor
                showScheduleVC.blockTwoColor = bBlockColor
                showScheduleVC.blockThreeColor = fBlockColor
                showScheduleVC.blockFourColor = dBlockColor
                showScheduleVC.blockFiveColor = gBlockColor
                showScheduleVC.blockOneTeach = cTeach
                showScheduleVC.blockTwoTeach = bTeach
                showScheduleVC.blockThreeTeach = fTeach
                showScheduleVC.blockFourTeach = dTeach
                showScheduleVC.blockFiveTeach = gTeach
                showScheduleVC.blockOneRoom = cRoom
                showScheduleVC.blockTwoRoom = bRoom
                showScheduleVC.blockThreeRoom = fRoom
                showScheduleVC.blockFourRoom = dRoom
                showScheduleVC.blockFiveRoom = gRoom
            } else if day == "6" {
                showScheduleVC.blockOne = aBlock
                showScheduleVC.blockTwo = hBlock
                showScheduleVC.blockThree = eBlock
                showScheduleVC.blockFour = fBlock
                showScheduleVC.lunchNumber = fLunch
                showScheduleVC.blockFive = cBlock
                showScheduleVC.blockOneColor = aBlockColor
                showScheduleVC.blockTwoColor = hBlockColor
                showScheduleVC.blockThreeColor = eBlockColor
                showScheduleVC.blockFourColor = fBlockColor
                showScheduleVC.blockFiveColor = cBlockColor
                showScheduleVC.blockOneTeach = aTeach
                showScheduleVC.blockTwoTeach = hTeach
                showScheduleVC.blockThreeTeach = eTeach
                showScheduleVC.blockFourTeach = fTeach
                showScheduleVC.blockFiveTeach = cTeach
                showScheduleVC.blockOneRoom = aRoom
                showScheduleVC.blockTwoRoom = hRoom
                showScheduleVC.blockThreeRoom = eRoom
                showScheduleVC.blockFourRoom = fRoom
                showScheduleVC.blockFiveRoom = cRoom
            } else if day == "7" {
                showScheduleVC.blockOne = bBlock
                showScheduleVC.blockTwo = aBlock
                showScheduleVC.blockThree = dBlock
                showScheduleVC.blockFour = eBlock
                showScheduleVC.lunchNumber = eLunch
                showScheduleVC.blockFive = gBlock
                showScheduleVC.blockOneColor = bBlockColor
                showScheduleVC.blockTwoColor = aBlockColor
                showScheduleVC.blockThreeColor = dBlockColor
                showScheduleVC.blockFourColor = eBlockColor
                showScheduleVC.blockFiveColor = gBlockColor
                showScheduleVC.blockOneTeach = bTeach
                showScheduleVC.blockTwoTeach = aTeach
                showScheduleVC.blockThreeTeach = dTeach
                showScheduleVC.blockFourTeach = eTeach
                showScheduleVC.blockFiveTeach = gTeach
                showScheduleVC.blockOneRoom = bRoom
                showScheduleVC.blockTwoRoom = aRoom
                showScheduleVC.blockThreeRoom = dRoom
                showScheduleVC.blockFourRoom = eRoom
                showScheduleVC.blockFiveRoom = gRoom
            } else {
                showScheduleVC.blockOne = cBlock
                showScheduleVC.blockTwo = bBlock
                showScheduleVC.blockThree = hBlock
                showScheduleVC.blockFour = fBlock
                showScheduleVC.lunchNumber = fLunch
                showScheduleVC.blockFive = dBlock
                showScheduleVC.blockOneColor = cBlockColor
                showScheduleVC.blockTwoColor = bBlockColor
                showScheduleVC.blockThreeColor = hBlockColor
                showScheduleVC.blockFourColor = fBlockColor
                showScheduleVC.blockFiveColor = dBlockColor
                showScheduleVC.blockOneTeach = cTeach
                showScheduleVC.blockTwoTeach = bTeach
                showScheduleVC.blockThreeTeach = hTeach
                showScheduleVC.blockFourTeach = fTeach
                showScheduleVC.blockFiveTeach = dTeach
                showScheduleVC.blockOneRoom = cRoom
                showScheduleVC.blockTwoRoom = bRoom
                showScheduleVC.blockThreeRoom = hRoom
                showScheduleVC.blockFourRoom = fRoom
                showScheduleVC.blockFiveRoom = dRoom
            }
        }
    }
}


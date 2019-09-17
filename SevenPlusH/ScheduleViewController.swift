//
//  ScheduleViewController.swift
//  SevenPlusH
//
//  Created by Shardul Joshi on 7/31/18.
//  Copyright © 2018 N/A. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Buttons on the schedule view controller
    @IBOutlet weak var dayTitle: UILabel!
    @IBOutlet weak var blockOneButton: UIButton!
    @IBOutlet weak var blockTwoButton: UIButton!
    @IBOutlet weak var blockThreeButton: UIButton!
    @IBOutlet weak var blockFourButton: UIButton!
    @IBOutlet weak var blockFiveButton: UIButton!
    @IBOutlet weak var lunchTime: UILabel!
    @IBOutlet weak var todayLunch: UILabel!
    
    // Variables to store information necessary
    var day: String!
    
    var blockOne: String!
    var blockTwo: String!
    var blockThree: String!
    var blockFour: String!
    var lunchNumber: String!
    var lunchTimeInput: String!
    var blockFive: String!
    
    var blockOneColor: UIColor!
    var blockTwoColor: UIColor!
    var blockThreeColor: UIColor!
    var blockFourColor: UIColor!
    var blockFiveColor: UIColor!
    
    var blockOneTeach: String!
    var blockTwoTeach: String!
    var blockThreeTeach: String!
    var blockFourTeach: String!
    var blockFiveTeach: String!
    
    var blockOneRoom: String!
    var blockTwoRoom: String!
    var blockThreeRoom: String!
    var blockFourRoom: String!
    var blockFiveRoom: String!
    
    var lunchOneTime = "11:07 am - 11:34 am"
    var lunchTwoTime = "11:36 am - 12:03 pm"
    var lunchThreeTime = "12:05 pm - 12:32 pm"
    var lunchFourTime = "12:34 pm - 1:01 pm"
    
    // Loads data received from main view controller to show schedule for the day
    override func viewWillAppear(_ animated: Bool) {
        if lunchNumber == "Lunch 1" {
            lunchTimeInput = lunchOneTime
        } else if lunchNumber == "Lunch 2" {
            lunchTimeInput = lunchTwoTime
        } else if lunchNumber == "Lunch 3" {
            lunchTimeInput = lunchThreeTime
        } else if lunchNumber == "Lunch 4" {
            lunchTimeInput = lunchFourTime
        } else {
            lunchTimeInput = "..."
        }
        dayTitle.text = ("Day " + day)
        blockOneButton.setTitle(blockOne, for: .normal)
        blockTwoButton.setTitle(blockTwo, for: .normal)
        blockThreeButton.setTitle(blockThree, for: .normal)
        blockFourButton.setTitle(blockFour, for: .normal)
        todayLunch.text = (lunchNumber + ":")
        lunchTime.text = lunchTimeInput
        blockFiveButton.setTitle(blockFive, for: .normal)
        blockOneButton.backgroundColor = blockOneColor
        blockTwoButton.backgroundColor = blockTwoColor
        blockThreeButton.backgroundColor = blockThreeColor
        blockFourButton.backgroundColor = blockFourColor
        blockFiveButton.backgroundColor = blockFiveColor
        self.blockOneButton.titleLabel?.textAlignment = NSTextAlignment.center
        self.blockTwoButton.titleLabel?.textAlignment = NSTextAlignment.center
        self.blockThreeButton.titleLabel?.textAlignment = NSTextAlignment.center
        self.blockFourButton.titleLabel?.textAlignment = NSTextAlignment.center
        self.blockFiveButton.titleLabel?.textAlignment = NSTextAlignment.center
    }
    
    enum ButtonType: Int {
        case blockOne = 0, blockTwo, blockThree, blockFour, blockFive
    }
    
    // Performs segue to whatever class is clicked
    @IBAction func showClassInfo(_ sender: Any) {
        switch(ButtonType(rawValue: (sender as AnyObject).tag)!) {
            case .blockOne:
                performSegue(withIdentifier: "showClassInfo", sender: blockOne)
            case .blockTwo:
                performSegue(withIdentifier: "showClassInfo", sender: blockTwo)
            case .blockThree:
                performSegue(withIdentifier: "showClassInfo", sender: blockThree)
            case .blockFour:
                performSegue(withIdentifier: "showClassInfo", sender: blockFour)
            case .blockFive:
                performSegue(withIdentifier: "showClassInfo", sender: blockFive)
        }
    }
    
    // Segue to class info page for each class
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showClassInfo" {
            let showClassInfoVC = segue.destination as! ClassInfoViewController
            let blockTitle = sender as! String
            showClassInfoVC.blockTitle = blockTitle
            if blockTitle == blockOne {
                showClassInfoVC.teacherName = blockOneTeach
                showClassInfoVC.roomNumber = blockOneRoom
                showClassInfoVC.blockColor = blockOneColor
            } else if blockTitle == blockTwo {
                showClassInfoVC.teacherName = blockTwoTeach
                showClassInfoVC.roomNumber = blockTwoRoom
                showClassInfoVC.blockColor = blockTwoColor
            } else if blockTitle == blockThree {
                showClassInfoVC.teacherName = blockThreeTeach
                showClassInfoVC.roomNumber = blockThreeRoom
                showClassInfoVC.blockColor = blockThreeColor
            } else if blockTitle == blockFour {
                showClassInfoVC.teacherName = blockFourTeach
                showClassInfoVC.roomNumber = blockFourRoom
                showClassInfoVC.blockColor = blockFourColor
            } else {
                showClassInfoVC.teacherName = blockFiveTeach
                showClassInfoVC.roomNumber = blockFiveRoom
                showClassInfoVC.blockColor = blockFiveColor
            }
        }
    }
}

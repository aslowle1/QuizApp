//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
//import GameKit
import AVFoundation

class ViewController: UIViewController {
   
    var playTime = GameStructure()
    
    let buttonColor = UIColor(red: 12/255, green: 121/255, blue: 150/255, alpha: 1)

    @IBOutlet weak var option1: UIButton!
    
    @IBOutlet weak var option2: UIButton!

    @IBOutlet weak var option3: UIButton!

    @IBOutlet weak var option4: UIButton?
    
    @IBOutlet weak var questions: UILabel!
    
    @IBOutlet weak var playNextQuestion: UIButton!
    
    @IBOutlet weak var nextGame: UIButton!
    
    @IBOutlet weak var overAllProgressMade: UIProgressView!
    
    //Executed if user decides to play again
    
    @IBAction func playAgain() {
        playTime.playAgain()
        buttonDisplay()
        option1.enabled = true
        option2.enabled = true
        option3.enabled = true
        option4!.enabled = true
        
    }
    
 // Used to display question and button as options
func buttonDisplay() {
    option1.hidden = false
    option1.setTitle(playTime.displayOptions().0, forState: UIControlState.Normal)
    option1.backgroundColor = buttonColor
    option1.layer.cornerRadius = 20
    
    option2.hidden = false
    option2.setTitle(playTime.displayOptions().1, forState: UIControlState.Normal)
    option2.backgroundColor = buttonColor
    option2.layer.cornerRadius = 20
    
    option3.hidden = false
    option3.setTitle(playTime.displayOptions().2, forState: UIControlState.Normal)
    option3.backgroundColor = buttonColor
    option3.layer.cornerRadius = 20
    
    questions.text = playTime.displayQuestion()
    playNextQuestion.hidden = true
    playNextQuestion.layer.cornerRadius = 20
    nextGame.hidden = true
    
    if playTime.displayOptions().3 != nil {
         option4!.hidden = false
        option4!.enabled = true
        option4!.setTitle(playTime.displayOptions().3, forState: UIControlState.Normal)
        option4!.backgroundColor = buttonColor
        option4!.layer.cornerRadius = 20
    }
    else {
         option4!.hidden = false
        option4!.setTitle("Disabled: Only 3 Choices", forState: UIControlState.Normal)
        option4!.enabled = false
        option4!.backgroundColor = buttonColor
        option4!.layer.cornerRadius = 20
    }
    nextGame.layer.cornerRadius = 50
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playTime.getRandomNumber()
        self.buttonDisplay()
        overAllProgressMade.setProgress(0.0, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that ca be recreated.

}

    
    func loadNextRoundWithDelay(seconds seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, delay)
        
        // Executes the nextRound method at the dispatch time on the main queue
        dispatch_after(dispatchTime, dispatch_get_main_queue()) {
               self.playAgainScreen()
        }
    }
    
   
    @IBAction func selectNextQuestion() {
        playTime.nextRound()
        buttonDisplay()
        option1.enabled = true
        option2.enabled = true
        option3.enabled = true
        if playTime.displayOptions().3 != nil {option4!.enabled = true}
        else {option4!.enabled = false
            
        }
    }

  // Executed once an option is selected
    
    @IBAction func selectOption(sender: UIButton) {
        guard let buttonSelection = sender.currentTitle else {
            return
        }
        playTime.buttonSelection = buttonSelection
        questions.text = playTime.selectAnswer()
        option1.enabled = false
        option2.enabled = false
        option3.enabled = false
        option4!.enabled = false
        if buttonSelection != playTime.displayAnswers(){
            soundName = "buzzer_x"
            sound()
            switch playTime.displayAnswers() {
            case option1.currentTitle!: option1.backgroundColor! = UIColor.greenColor().colorWithAlphaComponent(0.2)
                case option2.currentTitle!: option2.backgroundColor! = UIColor.greenColor().colorWithAlphaComponent(0.2)
                case option3.currentTitle!: option3.backgroundColor! = UIColor.greenColor().colorWithAlphaComponent(0.2)
                case option4!.currentTitle!: option4!.backgroundColor! = UIColor.greenColor().colorWithAlphaComponent(0.2)
            default: return
            }
        } else{
            soundName = "GameSound"
            sound()
        }
        overAllProgressMade.setProgress(Float(playTime.questionsAsked)/11, animated: true)

        if playTime.questionsAsked != playTime.questionsPerRound
        {playNextQuestion.hidden = false

        } else {playNextQuestion.hidden = true
            loadNextRoundWithDelay(seconds: 1)
        }
    }
    
    func playAgainScreen() {
    self.questions.text = "Your final score is" + " " + String(self.playTime.correctQuestions) + " Do you want to play again?"
    self.option1.hidden = true
    self.option2.hidden = true
    self.option3.hidden = true
    self.option4!.hidden = true
        nextGame.hidden = false
    }


var soundURL: NSURL?
var soundID:SystemSoundID = 0
var soundName = String()

func sound() {
let filePath = NSBundle.mainBundle().pathForResource(soundName, ofType: "wav")
soundURL = NSURL(fileURLWithPath: filePath!)
AudioServicesCreateSystemSoundID(soundURL!, &soundID)
AudioServicesPlaySystemSound(soundID)
}

}


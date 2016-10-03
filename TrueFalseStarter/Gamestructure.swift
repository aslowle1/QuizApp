//
//  Gamestructure.swift
//  TrueFalseStarter
//
//  Created by Andros Slowley on 9/14/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation
import GameKit



// List of Questions, Options and Appropriate Answer
    struct GameVariables {
    
    let originalQuestions = ["What is the process for fat metabolism known as?", "What type of bone is the Scapula?", "Which gland shares digestive and endocrine system responsibilities?", "What chamber of the heart receives oxygenated blood?", "Which is the 1st layer of any muscle?", "How muscle suddenly experiences a large force? What relaxes the muscle?", "The Draw-In method is a training method applicable to which Phase?", "Which is not a phase of the Cumulative Muscle Injury Cycle?", "Which is not a balance training parameter?", "What type of flexibility technique is most appropriate for phase 5 training?", "What zone is covered for heart rate percentage 65% - 75%?"]
    
    let originalOptions: [(String,String,String,String?)] = [("Lipolysis", "Glycolysis", "Kerbs Cycle", "Anaerobic"), ("Long", "Flat", "Sesamoid", "Irregular"), ("Thyroid", "Adrenal","Pituitry", "Pancreas"), ("Left Artium", "Right Artium", "Left Ventricle", "Right Ventricle"), ("Epimysium", "Mysosin", "Fascia", "Actin"), ("Spindle", "Machanoreceptor","Golgi Tendon","Axion"), ("2","3,4","2,4,5","1,2,3,4"), ("Muscle Spasm", "Scars", "Inflammation", "Adhesion"), ("Stable to Unstable", "Adhesion", "Slow to Fast", "Static to Dynamic"),("Dynamic", "Self-myofasical", "Static Stretching", "Active Isolated"),("Zone 1","Zone 2","Zone 3", nil)]
    
    let originalAnswer = ["Lipolysis","Flat","Pancreas","Right Ventricle","Epimysium","Golgi Tendon","2,4,5","Scars","Adhesion","Dynamic","Zone 1"]
}

    struct GameStructure{
        let questionsPerRound = 11
        var questionsAsked = 0
        var correctQuestions = 0
        var indexOfSelectedQuestion: Int = 0
        var playerScore = 0
        var buttonSelection = String()
        var questions = GameVariables().originalQuestions
        var options = GameVariables().originalOptions
        var answer = GameVariables().originalAnswer
    
// Method to Select Random Number
        
    mutating func getRandomNumber() -> (Int) {
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextIntWithUpperBound(questions.count)
        return indexOfSelectedQuestion
    }
    
// Input or Random Number to get random questions, options & answer
    func displayQuestion() -> String{
            return questions[indexOfSelectedQuestion]
      }
    
    func displayOptions() -> (String,String,String,String?){
            return options[indexOfSelectedQuestion]
    }
   
        func displayAnswers() -> String {
            return answer[indexOfSelectedQuestion]
        }
   
//
        mutating func selectAnswer() -> String {
        questionsAsked += 1
        
        let finalAnswer = answer[indexOfSelectedQuestion]
        
        if buttonSelection == finalAnswer {
            correctQuestions += 1
            playerScore += 1
            return "Awesome! You are correct...On to the next one"
        }
        else {
            return "Better luck on the next one?"
    }
    
}

   
mutating func nextRound() {
        questions.removeAtIndex(indexOfSelectedQuestion)
        options.removeAtIndex(indexOfSelectedQuestion)
        answer.removeAtIndex(indexOfSelectedQuestion)
        getRandomNumber()
    }
    
    mutating func playAgain() {
        questionsAsked = 0
        playerScore = 0
        correctQuestions = 0
        getRandomNumber()
         questions = GameVariables().originalQuestions
         options = GameVariables().originalOptions
         answer = GameVariables().originalAnswer
        
    }
}




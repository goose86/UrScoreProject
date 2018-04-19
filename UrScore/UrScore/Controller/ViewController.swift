//  Version 1, Use this first
//  ViewController.swift
//  Apple Submit version
//  UrScore
//  Created by Michael Martinez on 12/10/17.
//  Copyright © 2017 ForePlay Studios. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController{
    
    var audioPlayer:AVAudioPlayer!
    var audioPlayer2:AVAudioPlayer!
    var audioPlayer3:AVAudioPlayer!
    
    //Score variables
    var totalScore : Int = 0
    var nowScore : Int = 0
    var previousScore : Int = 0
    var currentScore : Int = 0

    //Par variables
    var holeNumber : Int = 1
    var totalPar : Int = 0
    var nowPar : Int = 0
    var previousPar : Int = 0
    var currentPar : Int = 0
    
    //Score and Hole Labels
    @IBOutlet weak var overallScore: UILabel!
    @IBOutlet weak var currentHole: UILabel!
    
    //Golf Ball hole sign
    @IBOutlet weak var holeSign: UILabel!
    
    
    
    //Par Stepper Code
    @IBOutlet weak var parStepper: UIStepper! //Stepper
    @IBOutlet weak var parStepLabel: UILabel! //Label
    @IBAction func parStepperAction(_ sender: Any) { //Action assigned to the par stepper
        parStepLabel.text = String(Int(parStepper.value))
        currentPar = Int(parStepper.value) //Store value enteres in currentPar variable
    }
    
    
    //Score Stepper Code
    @IBOutlet weak var scoreStepper: UIStepper! //Stepper
    @IBOutlet weak var scoreStepLabel: UILabel! //Label
    @IBAction func scoreStepperAction(_ sender: Any) { //Action assigned to the score stepper
        scoreStepLabel.text = String(Int(scoreStepper.value))
        currentScore = Int(scoreStepper.value) //Store value entered in currentScore variable
    }
    
    //MARK - Stepper Reset Function, Restart function, and Reset Nuttons anf 
    func resetButton(){
        scoreStepper.value = 0
        scoreStepLabel.text = "0"
        parStepper.value = 0
        parStepLabel.text = "0"
    }
    
    //Restart the hole count in the bottom container
    func restart(){
        holeNumber = 1
        currentScore = 0
        totalPar = 0
        totalScore = 0
        viewDidLoad()
        updateUI()
        overallScore.text = "Tee it high, let it fly!"
        holeSign.text = "1"
    }
    
    //Function to keep track of previous and next hole buttons
    @IBAction func holeTrack(_ sender: UIButton) {
        if sender.tag == 2{
            nextHole()
        }
        else if sender.tag == 1{
            if holeNumber > 1{
                previousHole()
            previousUpdateUI()
                
        }
      }
    } //Ends holeTrack button function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //golfClap Audio initialization
        let url = Bundle.main.url(forResource: "golfClap1", withExtension: "wav")
        
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: url!)
            audioPlayer.prepareToPlay()
        } catch let error as NSError {
            print(error.debugDescription)
        }
        
        //crowdGasp Audio initialization
        let url2 = Bundle.main.url(forResource: "crowdGasp", withExtension: "wav")
        
        do{
            audioPlayer2 = try AVAudioPlayer(contentsOf: url2!)
            audioPlayer2.prepareToPlay()
        } catch let error as NSError {
            print(error.debugDescription)
        }
        
        //crowdGasp Audio initialization
        let url3 = Bundle.main.url(forResource: "crowdRoar", withExtension: "wav")
        
        do{
            audioPlayer3 = try AVAudioPlayer(contentsOf: url3!)
            audioPlayer3.prepareToPlay()
        } catch let error as NSError {
            print(error.debugDescription)
        }
        
        //Initialize stepper and label to 0
        scoreStepper.value = 0
        scoreStepLabel.text = "0"
        parStepper.value = 0
        parStepLabel.text = "0"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark - Back 9 button and functions
    //Back 9 functions and button if the user is only playing the back 9 holes
    func backNineFunc(){
       
        holeNumber = 17
        currentScore = 0
        totalPar = 0
        totalScore = 0
        viewDidLoad()
        updateUI()
        overallScore.text = "Time for the back 9!"
        holeSign.text = "17"
    }
    
    func backUIAlert (title: String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            
            self.backNineFunc()
            
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //Back 9 Button and Label
    @IBOutlet weak var backNine: UIButton!
    @IBAction func backNineAction(_ sender: UIButton) {
    
        if sender.tag == 5{
            
            backUIAlert (title: "Are you sure you just want to play the back 9?", message: "")
        }
    }
    
    //Reset Button and Function
    //Restart Function
    func restartUIAlert (title: String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            
            self.restart()
            
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //End Round label and button
    @IBOutlet weak var resetLabel: UIButton!
    @IBAction func resetAction(_ sender: UIButton) {
        if sender.tag == 3 {
            
            restartUIAlert(title: "End Round", message: "Your current score is \(totalScore + Int(scoreStepper.value)) out of \(totalPar + Int(scoreStepper.value)), are you sure you want to end the round?")

        }
    }
    
    //Function to share your score when a round is complete-----> Unfinished
    func shareUIAlert(){
        
        let actionSheet = UIAlertController(title: "Your Final Score:", message: "\(totalScore) out of\(totalPar)", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "End Round", style: .default, handler: { (action) in
            actionSheet.dismiss(animated: true, completion: nil)
            
            self.restart()
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Share", style: .default, handler: { (action) in
            actionSheet.dismiss(animated: true, completion: nil)
        }))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func finalScoreMessage(){
    
        if ((totalScore + Int(scoreStepper.value)) - (totalPar + Int(parStepper.value))) > 20{
            print("I know it's not the score you wanted, but keep hitting the range")
        }
        else if ((totalScore + Int(scoreStepper.value)) - (totalPar + Int(parStepper.value))) >= 10 && ((totalScore + Int(scoreStepper.value)) - (totalPar + Int(parStepper.value))) <= 19{
            print("Great score! You're on your way to a sub 10 handicap")
        }
        else{
            print("Awesome score! You're better than 90% of golfers in the world!")
        }
    }
    
   //UI Update- Updates score banner at the top of the app
    func updateUI(){
        
        if (totalScore - totalPar) > 0{
            overallScore.text = "Score: +\(totalScore - totalPar) thru \(holeNumber - 1)"
            currentHole.text = "Par Total: \(totalPar)"
            holeSign.text = "\(holeNumber)"
        }
        else if (totalScore - totalPar) == 0{
            overallScore.text = "Score: Even thru hole \(holeNumber - 1)"
            currentHole.text = "Par Total: \(totalPar)"
            holeSign.text = "\(holeNumber)"
        }
        else{
            overallScore.text = "Score: \(totalScore - totalPar) thru \(holeNumber - 1)"
            currentHole.text = "Par Total: \(totalPar)"
            holeSign.text = "\(holeNumber)"
        }
    }
    
    func finalUpdateUI(){
        
        if (totalScore - totalPar) > 0{
            overallScore.text = "Score: +\(totalScore - totalPar) thru \(holeNumber - 1)"
            currentHole.text = "Par Total: \(totalPar)"
            holeSign.text = "18"
        }
        else if (totalScore - totalPar) == 0{
            overallScore.text = "Score: Even thru hole \(holeNumber - 1)"
            currentHole.text = "Par Total: \(totalPar)"
            holeSign.text = "18"
        }
        else{
            overallScore.text = "Score: \(totalScore - totalPar) thru \(holeNumber - 1)"
            currentHole.text = "Par Total: \(totalPar)"
            holeSign.text = "18"
        }
    }
    
    //Previous Hole UI Update - Updates score banner when previous button is pressed or invalid score/par input
    func previousUpdateUI(){
        if (totalScore - totalPar) > 0{
            overallScore.text = "Score: +\(totalScore - totalPar) thru \(holeNumber - 1)"
            currentHole.text = "Par Total: \(totalPar)"
            holeSign.text = "\(holeNumber)"
        }
        else if (totalScore - totalPar) == 0 && holeNumber == 1{
            overallScore.text = "Score: "
            currentHole.text = "Par Total: \(totalPar)"
            holeSign.text = "\(holeNumber)"
        }
            else if (totalScore - totalPar) == 0 {
                overallScore.text = "Score: Even thru hole \(holeNumber - 1)"
                currentHole.text = "Par Total: \(totalPar)"
                holeSign.text = "\(holeNumber)"
        }
        else{
            overallScore.text = "Score: \(totalScore - totalPar) thru \(holeNumber - 1)"
            currentHole.text = "Par Total: \(totalPar)"
            holeSign.text = "\(holeNumber)"
        }
    }
    
    
    //Next Hole function to preceed to the next hole
    func nextHole(){
        if holeNumber < 18 {
            updatePar()
            updateScore()
            holeNumber += 1
            scoreSounds()
            updateUI()
            resetButton()
        }
        else {
            updatePar()
            updateScore()
            holeNumber += 1
            finalUpdateUI()
            shareUIAlert()
            
        }
    }
    
    //PreviousHole function to go back to the last hole
    func previousHole(){
        if holeNumber > 1 || holeNumber < 19{
          
            holeNumber -= 1
            totalPar -= currentPar
            totalScore -= currentScore
            previousUpdateUI()
        }
    }
    
    
//    //Update score and Par or send error if == 0
//    func updateScore(){
//
//                if Int(scoreStepper.value) == 0 || Int(parStepper.value)  == 0 {
//
//                    let alert = UIAlertController(title: "Error", message: "Enter a valid score/par", preferredStyle: .alert)
//                    let scoreErrorAction = UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in //When you see in, make sure you use Self
//
//                        self.previousHole()
//                        //Use self when you see 'in', like above
//                    })
//                    alert.addAction(scoreErrorAction)
//                    present(alert, animated: true, completion: nil)
//                }
//                else{
//                    nowScore = previousScore + Int(scoreStepper.value)
//                    nowPar = previousPar + Int(parStepper.value)
//                }
//                totalScore = nowScore + totalScore
//                totalPar = nowPar + totalPar
//                scoreSounds() //SOUNDS
//            }


    
    //Update score or send error if == 0
    func updateScore(){

        if Int(scoreStepper.value) == 0 {

            let alert = UIAlertController(title: "Error", message: "Enter a valid score", preferredStyle: .alert)
            let scoreErrorAction = UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in //When you see in, make sure you use Self

                self.previousHole()
                //Use self when you see 'in', like above
            })
            alert.addAction(scoreErrorAction)
            present(alert, animated: true, completion: nil)
        }
        else{
            nowScore = previousScore + Int(scoreStepper.value)
      }
            totalScore = nowScore + totalScore
    }

    //Update the par of the current hole
    func updatePar(){

        if Int(parStepper.value) < 3 {

            let alert = UIAlertController(title: "Error", message: "Enter a valid par", preferredStyle: .alert)
            let parErrorAction = UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in

                self.previousHole()

            })
            alert.addAction(parErrorAction)
            present(alert, animated: true, completion: nil)
        }
        else{
            nowPar = previousPar + Int(parStepper.value)
      }
            totalPar = nowPar + totalPar
    }
    
    
//Audio Player Code**********************************************************************************************
    //This function poduces pop-up messages after a birdie or better is scored
    func scoreSounds(){
        if Int(parStepper.value) >= 3 && Int(scoreStepper.value) == 1{
            audioPlayer3.play()
            let alert = UIAlertController(title: "Hole In One!", message: "Either you're lying or that was a great shot!", preferredStyle: .alert)
            let parErrorAction = UIAlertAction(title: "Continue", style: .default, handler: { (UIAlertAction) in
            })
            alert.addAction(parErrorAction)
            present(alert, animated: true, completion: nil)
        }
        else if currentPar == 3 && currentScore == 2{
            audioPlayer.play()
            let alert = UIAlertController(title: "Birdie!", message: "Looking like Rory!", preferredStyle: .alert)
            let parErrorAction = UIAlertAction(title: "Continue", style: .default, handler: { (UIAlertAction) in
            })
            alert.addAction(parErrorAction)
            present(alert, animated: true, completion: nil)
        }
        else if currentPar == 4 && currentScore == 2{
            audioPlayer3.play()
            let alert = UIAlertController(title: "Eagle!", message: "Nice shot, Tiger!", preferredStyle: .alert)
            let parErrorAction = UIAlertAction(title: "Continue", style: .default, handler: { (UIAlertAction) in
            })
            alert.addAction(parErrorAction)
            present(alert, animated: true, completion: nil)
        }
        else if currentPar == 4 && currentScore == 3{
            audioPlayer.play()
            let alert = UIAlertController(title: "Birdie!", message: "Looking like Rory!", preferredStyle: .alert)
            let parErrorAction = UIAlertAction(title: "Continue", style: .default, handler: { (UIAlertAction) in
            })
            alert.addAction(parErrorAction)
            present(alert, animated: true, completion: nil)
        }
        else if currentPar == 5 && currentScore == 2{
            audioPlayer3.play()
            let alert = UIAlertController(title: "Albatross!", message: "Absolutely amazing!", preferredStyle: .alert)
            let parErrorAction = UIAlertAction(title: "Continue", style: .default, handler: { (UIAlertAction) in
            })
            alert.addAction(parErrorAction)
            present(alert, animated: true, completion: nil)
        }
        else if currentPar == 5 && currentScore == 3{
            audioPlayer3.play()
            let alert = UIAlertController(title: "Eagle!", message: "Nice shot, Tiger!", preferredStyle: .alert)
            let parErrorAction = UIAlertAction(title: "Continue", style: .default, handler: { (UIAlertAction) in
            })
            alert.addAction(parErrorAction)
            present(alert, animated: true, completion: nil)
        }
        else if currentPar == 5 && currentScore == 4{
            audioPlayer.play()
            let alert = UIAlertController(title: "Birdie!", message: "Looking like Rory!", preferredStyle: .alert)
            let parErrorAction = UIAlertAction(title: "Continue", style: .default, handler: { (UIAlertAction) in
            })
            alert.addAction(parErrorAction)
            present(alert, animated: true, completion: nil)
        }
        else if currentPar == 3 && currentScore > 5 {
            audioPlayer2.play()
            let alert = UIAlertController(title: "Ouch!", message: "At least it's only a par 3", preferredStyle: .alert)
            let parErrorAction = UIAlertAction(title: "Continue", style: .default, handler: { (UIAlertAction) in
            })
            alert.addAction(parErrorAction)
            present(alert, animated: true, completion: nil)
        }
        else if currentPar == 4 && currentScore > 7 {
            audioPlayer2.play()
            let alert = UIAlertController(title: "Ouch!", message: "DO NOT THROW YOUR CLUB", preferredStyle: .alert)
            let parErrorAction = UIAlertAction(title: "Continue", style: .default, handler: { (UIAlertAction) in
            })
            alert.addAction(parErrorAction)
            present(alert, animated: true, completion: nil)
        }
        else if currentPar == 5 && currentScore == 10 {
            audioPlayer2.play()
            let alert = UIAlertController(title: "Ouch!", message: "Deep breath, don't take this frustration to the next hole", preferredStyle: .alert)
            let parErrorAction = UIAlertAction(title: "Continue", style: .default, handler: { (UIAlertAction) in
            })
            alert.addAction(parErrorAction)
            present(alert, animated: true, completion: nil)
        }
    }
}




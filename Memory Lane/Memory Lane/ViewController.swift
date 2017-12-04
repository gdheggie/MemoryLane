//
//  ViewController.swift
//  HeggieGreg_AdaptiveLayoutProject
//
//  Created by Greg Heggie on 12/2/16.
//  Copyright © 2016 Greg Heggie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //UIElements
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet var imageViews: [UIImageView]!
    
    //variables
    var timeIs: Int = 0
    var timeNow: Int = 6
    var timer = Timer()
    var pairTimer = Timer()
    var cardDeck: [UIImage] = []
    var padCardDeck: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // when app loads up no cards are shown
        beginningCards()
        
        
        // set image to variable
        let sword = UIImage(named: "sword")!
        let filledFlask = UIImage(named: "bulb flask")!
        let coin =  UIImage(named: "coin")!
        let coins =  UIImage(named: "coins")!
        let coop = UIImage(named: "coop")!
        let  emptyFlask =  UIImage(named: "empty flask")!
        let eye =  UIImage(named: "eye")!
        let eyeball =  UIImage(named: "eyeball")!
        let fight =  UIImage(named: "fight")!
        let katana =  UIImage(named: "katana")!
        let knife =  UIImage(named: "knife")!
        let megaphone =  UIImage(named: "megaphone")!
        let microphone =  UIImage(named: "microphone")!
        let musicOff =  UIImage(named: "music off")!
        let musicOn =  UIImage(named: "music on")!
        
        // add images to a array for the deck
        
        // deck for phone
        cardDeck = [sword, filledFlask, coin, coins, coop, emptyFlask, eye, eyeball, fight, katana, sword, filledFlask, coin, coins, coop, emptyFlask, eye, eyeball, fight, katana]
        // deck for ipad
        padCardDeck = [sword, filledFlask, coin, coins, coop, emptyFlask, eye, eyeball, fight, katana, knife, megaphone, microphone, musicOff, musicOn, sword, filledFlask, coin, coins, coop, emptyFlask, eye, eyeball, fight, katana, knife, megaphone, microphone, musicOff, musicOn]
        
        // give tap gesture to cards
        for x in 0..<imageViews.count{
            let cardChosen = UITapGestureRecognizer(target: self, action: #selector(ViewController.cardSeletected(_:)))
            imageViews[x].addGestureRecognizer(cardChosen)
        }
        cardFaces()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //tap function that highlights the card to show the image on it
    @objc func cardSeletected(_ sender: UITapGestureRecognizer) {
        let showCard = imageViews[sender.view!.tag]
        showCard.isHighlighted = true
        pairTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.correctPair), userInfo: nil, repeats: false)
    }

    // play button function that starts the timer and makes the play button disappear
    @IBAction func playButton(_ sender: UIButton) {
        showCards()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.timeTracker), userInfo: nil, repeats: true)
        sender.isHidden = true
    }
    
    // function that shows timer value on label
    @objc func timeTracker() {
        timeNow -= 1
        let countdown = timeNow % 60
        switch countdown {
        case 1...6:
            timerLabel.text = "-0:0\(countdown)"
            for x in imageViews {
                x.isHighlighted = true
                x.isUserInteractionEnabled = false
            }
        case 0:
            timerLabel.text = "0:00"
            for x in imageViews {
                x.isHighlighted = false
                x.isUserInteractionEnabled = true
            }
        default:
            timeIs += 1
            let minutes = timeIs / 60
            let seconds = timeIs % 60
            if seconds < 10 {
                timerLabel.text = "\(minutes):0\(seconds)"
            } else {
                timerLabel.text = "\(minutes):\(seconds)"
            }
        }
    }
    
    // function that starts up before the play button is hit
    func beginningCards() {
        for x in imageViews {
            x.isHidden = true
        }
    }
    
    //function that shows cards after play button is hit
    func showCards() {
        for x in imageViews {
            x.isHidden = false
        }
    }
    
    // function to add images to highlighted imageViews based on device
    func cardFaces() {
        if UIDevice.current.userInterfaceIdiom == .phone {
            imageViews.removeLast(10)
                for x in imageViews {
                    let card = Int(arc4random_uniform(UInt32(cardDeck.count)))
                    x.highlightedImage = cardDeck[card]
                    cardDeck.remove(at: card)
                }
        }else {
            for x in imageViews {
                let card = Int(arc4random_uniform(UInt32(padCardDeck.count)))
                x.highlightedImage = padCardDeck[card]
                padCardDeck.remove(at: card)
                
            }
        }
    }
    
    // alert controller for winning.
    func winner() {
        let gameOver = UIAlertController(title: "You Won!", message: "Would you like to play again?", preferredStyle: UIAlertControllerStyle.alert)
        let confirm = UIAlertAction(title: "New Game", style: .default) { (action: UIAlertAction) in
            self.rePlay()}
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        gameOver.addAction(confirm)
        gameOver.addAction(cancel)
        self.present(gameOver, animated: true , completion: nil)

    }
    
    //replay the game function
    func rePlay() {
        self.viewDidLoad()
        self.viewWillAppear(true)
    }
    
    // check if cards match
    @objc func correctPair() {
        var highlights = 0
        for x in imageViews {
            if x.isHighlighted {
                highlights += 1
                switch highlights {
                case 0...1:
                    highlights += 1
                default:
                    if highlights == 2  {
                       // winner()
                        // this would be the check for if the images are the same but I could not find anyway to make it work. 
                        }
                    }
                }
            }
        }
}

//
//  ViewController.swift
//  Pokemon
//
//  Created by Aaron on 9/29/15.
//  Copyright © 2015 Aaron. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {

    var pokemonList = [String]()
    var score = 0
    var correctAnswer = 0


    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        let fm = NSFileManager.defaultManager()
        let path = NSBundle.mainBundle().resourcePath!
        let images = try! fm.contentsOfDirectoryAtPath(path)
        
        for image in images {
            if image.hasSuffix("png") {
                let imageTitle = image.stringByReplacingOccurrencesOfString(".png", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)

                pokemonList.append(imageTitle)
            }
        }

        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        pokemonList = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(pokemonList) as! [String]

        button1.setImage(UIImage(named: pokemonList[0]), forState: .Normal)
        button2.setImage(UIImage(named: pokemonList[1]), forState: .Normal)
        button3.setImage(UIImage(named: pokemonList[2]), forState: .Normal)

        correctAnswer = GKRandomSource.sharedRandom().nextIntWithUpperBound(3)
        title = pokemonList[correctAnswer].uppercaseString
    }
    
    @IBAction func buttonTapped(sender: UIButton) {
        var title: String
        if sender.tag == correctAnswer {
            title = "Correct"
            ++score
        } else {
            title = "Wrong"
            --score
        }
        let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .Default, handler: askQuestion))
        presentViewController(ac, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


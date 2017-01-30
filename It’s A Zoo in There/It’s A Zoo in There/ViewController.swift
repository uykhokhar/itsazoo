//
//  ViewController.swift
//  It’s A Zoo in There
//
//  Created by MouseHouseApp on 1/28/17.
//  Copyright © 2017 Umar Khokhar. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIScrollViewDelegate {
    
    
    var zooAnimals: [Animal] = []
    var animalSounds: AVAudioPlayer!
    var scrollInitial: Int = 0
    var scrollNext: Int = 0
    var scrollDelta: Int = 0
    
    
    // MARK: IBOutlets
    @IBOutlet weak var labelBottom: UILabel!
    @IBOutlet weak var labelTop: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad(){
        super.viewDidLoad()
        
        let turtleImage = UIImage(named: "turtle")
        let frogImage = UIImage(named: "frog")
        let monkeyImage = UIImage(named: "monkey")
        
        
        // Initialize array with animals
        let dragon = Animal(name: "Dragon", species: "Caretta caretta", age: 27, image: turtleImage!, soundPath: "turtleSound")
        
        let prince = Animal(name: "Prince", species: "Kaloula pulchra", age: 1, image: frogImage!, soundPath: "frogSound")
        
        let littleSister = Animal(name: "MonkeyAstronaut", species: "haplorhine", age: 2, image: monkeyImage!, soundPath: "monkeySound")
        
        zooAnimals.append(dragon)
        zooAnimals.append(prince)
        zooAnimals.append(littleSister)
        
        //prior to shuffle test
        print("prior to shuffle")
        zooAnimals[0].dumpAnimalObject()
        zooAnimals[1].dumpAnimalObject()
        zooAnimals[2].dumpAnimalObject()
        
        //shuffle animals
        print("post shuffle")
        zooAnimals.shuffle()
        zooAnimals[0].dumpAnimalObject()
        zooAnimals[1].dumpAnimalObject()
        zooAnimals[2].dumpAnimalObject()
        
        
        // Properties of scrollview
        self.scrollView.contentSize = CGSize(width: 1125, height: 500)
        self.scrollView.backgroundColor = UIColor.darkGray
        self.scrollView.isPagingEnabled = true
        self.scrollView.delegate = self
        
        // Images and buttons in scroll view
        for i in 0...(zooAnimals.count - 1) {
            
            // Buttons for scroll view
            let buttonA = UIButton(frame: CGRect(x: (375 * i)+58, y: 410, width: 259, height: 100))
            buttonA.setTitle(zooAnimals[i].name, for: UIControlState.normal)
            buttonA.addTarget(self, action: #selector(ViewController.buttonTapped(button:)), for: UIControlEvents.touchUpInside)
            buttonA.tag = i
            self.scrollView.addSubview(buttonA)
            
            // Images for scroll view
            let imageViewA = UIImageView(image: zooAnimals[i].image)
            imageViewA.frame = CGRect(x: (375 * i), y: 18, width: 375, height: 375)
            self.scrollView.addSubview(imageViewA)
            
        }
        
        // Labels
        labelTop.text = ""
        labelBottom.text = zooAnimals[0].name

        

    }
    
    
    func buttonTapped(button: UIButton!) {
        
        //dump animal object
        zooAnimals[button.tag].dumpAnimalObject()
        
        
        // alert
        let alert = UIAlertController(title: "\(zooAnimals[button.tag].name)", message: "This \(zooAnimals[button.tag].species) is \(String(zooAnimals[button.tag].age)) years old", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        // sound
        /// - Attributions: https://www.hackingwithswift.com/example-code/media/how-to-play-sounds-using-avaudioplayer
        let path = Bundle.main.path(forResource: zooAnimals[button.tag].soundPath, ofType:"mp3")!
        let url = URL(fileURLWithPath: path)
        
        do {
            let sound = try AVAudioPlayer(contentsOf: url)
            animalSounds = sound
            sound.play()
        } catch {
            // couldn't load file :(
        }
        
    }
    
    // MARK: = UIScrollViewDelegate Methods
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("Scrolling \(scrollView.contentOffset)")
        
        let offset = Int(scrollView.contentOffset.x)
        let alpha = CGFloat(abs(Double(Double(offset % 375)/370.0)))
        
        scrollNext = offset
        scrollDelta = offset - scrollInitial
        
        if offset < 375 && scrollDelta < 0 {
            labelTop.text = zooAnimals[0].name
            print("negative scrolling \(String(scrollDelta)): top label should be \(zooAnimals[0].name)")
            labelTop.alpha = 1-alpha
            labelBottom.alpha = alpha
        }else if offset < 375 && scrollDelta > 0 {
            labelTop.text = zooAnimals[1].name
            labelTop.alpha = alpha
            labelBottom.alpha = 1-alpha
        }else if offset < 750 && scrollDelta < 0 {
            labelTop.text = zooAnimals[1].name
            print("negative scrolling \(String(scrollDelta)): top label should be \(zooAnimals[0].name)")
            labelTop.alpha = 1-alpha
            labelBottom.alpha = alpha
        }else if offset < 750 && scrollDelta > 0 {
            labelTop.text = zooAnimals[2].name
            labelTop.alpha = alpha
            labelBottom.alpha = 1-alpha
        }

        
        
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("Begin Scrolling from \(scrollView.contentOffset)")
        
        scrollInitial = Int(scrollView.contentOffset.x)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("Scroll view end declerating \(scrollView.contentOffset)")
        
        let offset = Int(scrollView.contentOffset.x)
        
        switch offset {
            
        case 375:
            print("Second page")
            labelBottom.text = zooAnimals[1].name
            labelTop.text = ""
            
        case 750:
            print("Third page")
            labelBottom.text = zooAnimals[2].name
            labelTop.text = ""
        default:
            print("First page")
            labelBottom.text = zooAnimals[0].name
            labelTop.text = ""
        }
        
        labelBottom.alpha = 1
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


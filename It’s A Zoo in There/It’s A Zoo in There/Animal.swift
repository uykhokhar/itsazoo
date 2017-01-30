//
//  Animal.swift
//  It’s A Zoo in There
//
//  Created by MouseHouseApp on 1/28/17.
//  Copyright © 2017 Umar Khokhar. All rights reserved.
//

import Foundation
import UIKit

class Animal{
    
    let name: String
    let species: String
    let age: Int
    let image: UIImage
    let soundPath: String
    
    /**
    - TODO: include soundPath: String in init.
    */
    
    init(name: String, species: String, age: Int, image: UIImage, soundPath: String){
        self.name = name
        self.species = species
        self.age = age
        self.image = image
        self.soundPath = soundPath
    }
    
    
    func dumpAnimalObject() {
        print("Animal Object: name=\(name), species=\(species), age=\(String(age)), image=\(image)")
    }
    
    
    
    
}

extension Array {
    mutating func shuffle() {
        
        let numElements = self.count
        
        //proceed through array elements and swap them with random elements
        for i in 0...(numElements-1) {
            let randomNum = Int(arc4random_uniform(UInt32(numElements)))
            
            //swapping a location with itself is not supported
            if i != randomNum {
                swap(&self[i], &self[randomNum])
            }
            
        }
    }
    
}

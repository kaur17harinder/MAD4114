//
//  ViewController.swift
//  FartApp
//
//  Created by MacStudent on 2018-07-09.
//  Copyright © 2018 MacStudent. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {

    //VARIABLES AND OUTLETS
    
    //CREATE A SOUND PLAYER VARIABLE
    var audioplayer : AVAudioPlayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   //actions
    @IBAction func playFart(_ sender: UIButton) {
      
       var url = Bundle.main.url(forResource: "fart-03", withExtension: "mp3")
        if(sender.tag == 1)
        {
             print("Wet Fart")
         url = Bundle.main.url(forResource: "fart-03", withExtension: "mp3")
        }
        else if(sender.tag == 2)
        {
            print("Squeaky Fart")
          url = Bundle.main.url(forResource: "fart-squeak-01", withExtension: "mp3")
        }
        else if(sender.tag == 3){
            print("Too Many Lentil Fart")
          url = Bundle.main.url(forResource: "fart-06", withExtension: "mp3")
        }
        
        //1.creating a variable to represent the file location
        //that url code
        
        do{
            //2.tell the audio player the location of the file
            audioplayer = try AVAudioPlayer(contentsOf: url!)
            
            //3.play the sound
            audioplayer?.play()
            
        }
        catch{
            print("Error Occured")
        }
        
        
      
        
    }
    
    

    
    
    
}


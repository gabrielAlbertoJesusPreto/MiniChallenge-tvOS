//
//  QuestionViewController.swift
//  GameShowApp
//
//  Created by Liliane Bezerra Lima on 17/05/16.
//  Copyright © 2016 Gabriel Alberto. All rights reserved.
//

import UIKit


class QuestionViewController: UIViewController {
    

    @IBOutlet weak var constarintProgressBar: NSLayoutConstraint!
    @IBOutlet weak var labelQuestion: UILabel!
    @IBOutlet weak var buttonOption1: CustomButton!
    @IBOutlet weak var buttonOption2: CustomButton!
    @IBOutlet weak var buttonOption3: CustomButton!
    @IBOutlet weak var buttonOption4: CustomButton!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var timmer = NSTimer()
    var aux:CGFloat!
    
    var a1:Answer!
    var a2:Answer!
    var a3:Answer!
    var a4:Answer!
    var r:Question!
    
    let question = ["Qual a capital do Brasil ?", "Quando foi a independência do Brasil?","Qual foi o primeiro presidente a sofrer Impeachment?"]
    let respC = ["Brasília","07 de Setembro","Fernando Collor"]
    let resp1 = ["Rio de Janeiro","25 de Novembro","Dilma Rousseff" ]
    let resp2 = ["São Paulo", "26 de Maio", "Jânio Quadros"]
    let resp3 = ["Buenos Aires", "21 de Abril","Getúlio Vargas"]
    
    var counter: Int = 100 {
        didSet {
//            let fractional = Float(counter)/100.0
            let animated = counter != 0
            
            progressBar.setProgress(0, animated: animated)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        aux = 10
//        timmer = NSTimer.scheduledTimerWithTimeInterval(Double((300)/self.view.frame.width), target: self, selector: #selector(QuestionViewController.upadateProgressBar), userInfo: nil, repeats: true)
        
        timmer = NSTimer.scheduledTimerWithTimeInterval(0.001, target: self, selector: #selector(QuestionViewController.upadateProgressBar), userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view.
        self.updateQuestion(2)
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        upadateProgressBar()
    }
    
    func updateQuestion(index:Int) {
        
        labelQuestion.text = question[index]
        buttonOption1.setTitle(respC[index], forState:UIControlState.Normal)
        buttonOption2.setTitle(resp3[index], forState:UIControlState.Normal)
        buttonOption3.setTitle(resp2[index], forState:UIControlState.Normal)
        buttonOption4.setTitle(resp1[index], forState:UIControlState.Normal)
    }
    
    override func viewWillDisappear(animated: Bool) {
        timmer.invalidate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func upadateProgressBar() {
        self.counter -= 1
    }
    
    @IBAction func option1(sender: AnyObject) {
        timmer.invalidate()
    }

    @IBAction func option2(sender: AnyObject) {
        timmer.invalidate()
    }
    @IBAction func option3(sender: AnyObject) {
        timmer.invalidate()
    }
    
    @IBAction func option4(sender: AnyObject) {
        timmer.invalidate()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}

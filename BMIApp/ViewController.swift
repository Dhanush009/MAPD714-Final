//
//  Name: Dhanush Sriram
//  Id: 301299251
//  MAPD 714 - iOS Development - Final Exam
//
//

import UIKit

class ViewController: UIViewController {
    
    private var mod = [Bmi]()
// Declaring Components of UI
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var age: UITextField!
    
    @IBOutlet weak var gender: UITextField!
    
    @IBOutlet weak var weight: UITextField!
    
    @IBOutlet weak var height: UITextField!
    
    @IBOutlet weak var weiLabel: UILabel!
    
    @IBOutlet weak var heiLabel: UILabel!
    
    @IBOutlet weak var bmiAns: UILabel!
    
    @IBOutlet weak var msgAns: UILabel!
    
    var unit = ""
    // Checking for units (SI or Imperial)
    @IBAction func units(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0{
            unit = "SI"
            weiLabel.text = "Weight(kg)"
            heiLabel.text = "Height(cm)"
        }else{
            unit = "Imperial"
            weiLabel.text = "Weight(lb)"
            heiLabel.text = "Height(in)"
        }
        
    }
    
    //Creating a context for CoreData
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
       }
    
    //Function to calculate BMI
    @IBAction func calcBMI(_ sender: Any) {
        
        let strW : NSString = weight.text! as NSString
        
        let strH : NSString = height.text! as NSString
        let strN : NSString = username.text! as NSString
        let strA : NSString = age.text! as NSString
        let strG : NSString = gender.text! as NSString
        
        let w = strW.doubleValue
        let h = strH.doubleValue
        
        var bmi = 0.0
        var ans = 0.0
        
        if unit == "Imperial"{
            bmi = ((w * 703) / (h*h))
            ans = (ceil(bmi * 10)) / 10
            
        }
        else{
            bmi = w / ((h/100)*(h/100))
            ans = (ceil(bmi * 10)) / 10
            
        }
        
        let c: String = String(ans)
        
        if(ans < 16){
            bmiAns.text = "Your BMI is " + c
            msgAns.text = "You are severely thin"
        }
        
        else if(ans >= 16 && ans < 17){
            bmiAns.text = "Your BMI is " + c
            msgAns.text = "You are moderately thin"
        }
        
        else if(ans >= 17 && ans < 18.5){
            bmiAns.text = "Your BMI is " + c
            msgAns.text = "You are mildly thin"
        }
        
        else if(ans >= 18.5 && ans < 25){
            bmiAns.text = "Your BMI is " + c
            msgAns.text = "You are normal"
        }
        
        else if(ans >= 25 && ans < 30){
            bmiAns.text = "Your BMI is " + c
            msgAns.text = "You are Overweight"
        }
        
        else if(ans >= 30 && ans < 35){
            bmiAns.text = "Your BMI is " + c
            msgAns.text = "You are in Obese Class 1"
        }
        
        else if(ans >= 35 && ans < 40){
            bmiAns.text = "Your BMI is " + c
            msgAns.text = "You are in Obese Class 2"
        }
        
        else if(ans >= 40){
            bmiAns.text = "Your BMI is " + c
            msgAns.text = "You are in Obese Class 3"
        }
        
        createItem(name: strN as String, age: strA as String, gender: strG as String, weight: w, height:h , bmi: ans)
        
    }
    
    //Function to add create a new item in Database
    
    func createItem(name: String, age: String, gender: String, weight: Double,height: Double, bmi: Double ){
        
        let newItem = Bmi(context: context)
        
        newItem.name = name
        newItem.age = age
        newItem.gender = gender
        newItem.weight = weight
        newItem.height = height
        newItem.bmi = bmi
        newItem.date = Date()
        
        do{
            try context.save()
            
        }
        catch{
            //error
        }
    }
    
    
}


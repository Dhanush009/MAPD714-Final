//
//  Name: Dhanush Sriram
//  Id: 301299251
//  MAPD 714 - iOS Development - Final Exam
//  Xcode Version : 14.0
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var mod = [Bmi]()
    
    //function to add new details in second screen
    @IBAction func addBmi(_ sender: UIButton) {
        
        sender.addTarget(self, action: #selector(showAlert),for: .touchUpInside)
        
    }
    
    //alert that takes in two values(weight and height) and computes BMI & updates date automatically
    @objc private func showAlert() {
        
        let alert = UIAlertController(title: "New Record",
                                      message:"Enter Details",
                                      preferredStyle: .alert)
        
        alert.addTextField{field in
            field.placeholder = "Weight(kg)"
            field.returnKeyType = .next
        }
        
        alert.addTextField{field in
            field.placeholder = "Height(cm)"
            field.returnKeyType = .next
        }
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { _ in
            guard let fields = alert.textFields, fields.count == 2 else {
                return
            }
            let wei = fields[0]
            let hei = fields[1]
            
            guard let we = wei.text, !we.isEmpty,
                  let he = hei.text, !he.isEmpty else {
                return
            }
            
            let w = Double(we)!
            let h = Double(he)!
            var bmi = 0.0
            var ans = 0.0
            
            bmi = w / ((h/100)*(h/100))
            ans = (ceil(bmi * 10)) / 10
            
            self.createItem(name: "n", age: "2", gender: "m", weight: w, height: h, bmi: ans)
            
        }))
        
        present(alert, animated: true)
        
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    //creating a context for Coredata
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        getAllItems()
        let nib = UINib(nibName: "BmiCellTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "bmiCell")
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        getAllItems()
        
        if mod.isEmpty{
            self.performSegue(withIdentifier: "screen", sender: self)
            getAllItems()
        }
    }
    
    
    //coredata functions for CRUD
    
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
            getAllItems()
        }
        catch{
            //error
        }
    }
    
    func getAllItems(){
        
        do{
            mod = try context.fetch(Bmi.fetchRequest())
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
        catch{
            //error
        }
        
    }
    
    func deleteItem(item:Bmi){
        context.delete(item)
        do{
            try context.save()
            viewDidAppear(true)
        }
        catch{
            //error
        }
    }
    
    func updateItem(item: Bmi, weight: Double, bmi: Double){
        item.weight = weight
        item.bmi = bmi
        item.date = Date()
        do{
            try context.save()
            getAllItems()
        }
        catch{
            //error
        }
    }
    
    //table functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mod.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = mod[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "bmiCell", for: indexPath) as! BmiCellTableViewCell
        
        cell.weightAns.text = String(format: "%.2f", model.weight)
        cell.bmiAns.text = String(format: "%.2f", model.bmi)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YY"
        cell.dateAns.text = dateFormatter.string(from: model.date!)
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let model = mod[indexPath.row]
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        sheet.addAction(UIAlertAction(title:"Edit",style: .default,handler: {_ in
            
            let alert = UIAlertController(title: "Edit Record",
                                          message:"Enter Details",
                                          preferredStyle: .alert)
            
            alert.addTextField{field in
                field.placeholder = "Weight(kg)"
                field.returnKeyType = .next
            }
            
            alert.addTextField{field in
                field.placeholder = "Height(cm)"
                field.returnKeyType = .next
            }
            
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
                guard let fields = alert.textFields, fields.count == 2 else {
                    return
                }
                let wei = fields[0]
                let hei = fields[1]
                
                guard let we = wei.text, !we.isEmpty,
                      let he = hei.text, !he.isEmpty else {
                    return
                }
                
                let w = Double(we)!
                let h = Double(he)!
                var bmi = 0.0
                var ans = 0.0
                
                bmi = w / ((h/100)*(h/100))
                ans = (ceil(bmi * 10)) / 10
                
                self.updateItem(item: model, weight: w, bmi: ans)
                
            }))
            
            self.present(alert, animated: true)
            
        }))
        sheet.addAction(UIAlertAction(title:"Delete",style: .destructive,handler: {_ in
            self.deleteItem(item: model)
        }))
        sheet.addAction(UIAlertAction(title:"Cancel",style: .cancel,handler: nil))
        
        present(sheet, animated: true)
        
    }

}

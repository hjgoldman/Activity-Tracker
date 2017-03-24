//
//  ActivityTableViewController.swift
//  Activity Tracker
//
//  Created by Hayden Goldman on 3/23/17.
//  Copyright © 2017 Hayden Goldman. All rights reserved.
//

import UIKit
import CoreMotion

class ActivityTableViewController: UITableViewController {
    
    var pedometer :CMPedometer!
    var altimeter :CMAltimeter!
    
    var days = [Day]()
    var total :Day?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pedometer = CMPedometer()
        self.altimeter = CMAltimeter()
        
        let calendar = Calendar.current

        
        for day in 1...7 {
        
            let pastDay = calendar.date(byAdding: .day, value: -day, to: Date())
        
            self.pedometer.queryPedometerData(from: pastDay!, to: Date()) { (data :CMPedometerData?, error :Error?) in
                
                let day = Day()
                day.steps = data?.numberOfSteps as Int!
                day.date = data?.startDate.description as String!
                
                self.days.append(day)
                
//                print((data?.numberOfSteps)!)
//                print((data?.startDate.description)!)

            }
        }
        

    }



    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.days.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath)

        // Configure the cell...
        
        let day = self.days[indexPath.row]
        
        cell.textLabel?.text = String(day.steps)

        return cell
    }
 

   
}

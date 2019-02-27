//
//  MainViewController.swift
//  ChargeMe
//
//  Created by 大隈隼 on 2019/01/14.
//  Copyright © 2019 大隈隼. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var alertCount: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //countDown()
        
        clock()
        // Do any additional setup after loading the view.
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func clock() {
        let timer = Timer.scheduledTimer(
                        timeInterval: 1.0,
                        target: self,
                        selector: #selector(countDown(_:)),
//                        selector: #selector(getNowTime(_:)),
                        userInfo: nil,
                        repeats: true)
        timer.fire()
    }
    
    @objc func getNowTime(_ sender: Timer) {
        
        let dateFormatter: DateFormatter = DateFormatter()
        let now = Date()
        
        dateFormatter.locale = Locale(identifier: "ja")
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .medium
        alertCount.text = dateFormatter.string(from: now)
    }
    
    @objc func countDown(_ sender: Timer) {
        let dateFormatter: DateFormatter = DateFormatter()
        let now = Date()
        let userDefaults = UserDefaults.standard
//        let time = userDefaults.object(forKey: "sleepTime") as! String;
        dateFormatter.locale = Locale(identifier: "ja")
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .medium
        let userDate = userDefaults.object(forKey: "sleepTime")
        let sleepTime = dateFormatter.date(from: userDefaults.object(forKey: "sleepTime") as! String)
        
        alertCount.text = String(calcuclateInterval(sleepTime: sleepTime!))
        
    }
    
    @objc func calcuclateInterval(sleepTime: Date) -> Int{
        var interval = Int(sleepTime.timeIntervalSinceNow)
        
        if interval < 0 {
            interval = 86400 - (0 - interval)
        }
        
        let calender = Calendar.current
        let seconds = calender.component(.second, from: sleepTime)
        
        return interval - seconds
    }

}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let userDefaults = UserDefaults.standard
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "timeCell", for: indexPath) as! TimeCollectionViewCell
            cell.updateCell(time: userDefaults.object(forKey: "sleepTime") as! String,
                            meridian: userDefaults.object(forKey: "sleepMeridian") as! String )
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "alertCell", for: indexPath) as! AlertCollectionViewCell
            cell.updateCell(timing: userDefaults.object(forKey: "alertTiming") as! String)
            return cell
        }
    }
}

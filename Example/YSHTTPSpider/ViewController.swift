//
//  ViewController.swift
//  YSHTTPSpider
//
//  Created by acct<blob>=<NULL> on 03/03/2019.
//  Copyright (c) 2019 acct<blob>=<NULL>. All rights reserved.
//

import UIKit
import Alamofire
import YSHTTPSpider

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: Notification.Name.Task.DidResume, object: nil, queue: nil) { (notification) in
            SpiLogger.outStream(notification.userInfo, name: Notification.Name.Task.DidResume)
        }
        NotificationCenter.default.addObserver(forName: Notification.Name.Task.DidComplete, object: nil, queue: nil) { (notification) in
            SpiLogger.outStream(notification.userInfo, name: Notification.Name.Task.DidComplete)
        }
        

        Spi(Common.getAllRegion()).send().responseSpiObjects { (response:DataResponse<[AppInfo]>) in
            switch response.result {
            case .success(let value):
                print(value)
            case .failure(let error):
                
                print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


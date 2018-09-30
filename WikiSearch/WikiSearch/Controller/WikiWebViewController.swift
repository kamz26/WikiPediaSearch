//
//  WikiWebViewController.swift
//  WikiSearch
//
//  Created by user142467 on 9/29/18.
//  Copyright © 2018 user142467. All rights reserved.
//

import UIKit

class WikiWebViewController: UIViewController {

    @IBOutlet weak var wikiWebview: UIWebView!
    var strText:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "https://en.wikipedia.org/wiki/\(strText!.formattedString())"
        let request = URLRequest.init(url: URL.init(string: url)!, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 120)
        wikiWebview.loadRequest(request)
        
        
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

}

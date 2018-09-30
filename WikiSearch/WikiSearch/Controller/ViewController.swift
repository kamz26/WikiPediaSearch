//
//  ViewController.swift
//  WikiSearch
//
//  Created by user142467 on 9/29/18.
//  Copyright © 2018 user142467. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var wikkiVM: WikiViewModel!
    var selectedIndex:Int?
    var selectedSection:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.delegate = self
        searchTableView.dataSource = self
        wikkiVM = WikiViewModel()
       
        searchTableView.register(SearchTableViewCell.nib, forCellReuseIdentifier: SearchTableViewCell.reuseIndentifier)
        // Do any additional setup after loading the view, typically from a nib
    }
    override func viewWillAppear(_ animated: Bool) {
      refreshData()
      searchBar.resignFirstResponder()
      searchTableView.reloadData()
    }
    
    
    func refreshData(){
        wikkiVM.fetchPersitedData { (bool) in
            DispatchQueue.main.sync {
                self.searchTableView.reloadData()
            }
        }
        
    }
    
    
    @objc func clearHistoryAction(_ sender:UIButton){
        
        wikkiVM.clearPersistedData { (bool) in
            DispatchQueue.main.async {
                self.refreshData()
                self.searchTableView.reloadData()
            }
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "send"{
            let destination = segue.destination as! WikiWebViewController
            if let wikiVM = wikkiVM, let wikiData = wikiVM.wikiModel, let query = wikiData.query , let pages = query.pages, pages.count > 0 && selectedIndex == 0{
                destination.strText = pages[selectedIndex!].title
            }
            
            if let wikiVm = wikkiVM, let pageData = wikiVm.pageData, pageData.count > 0 && selectedSection == 1{
                destination.strText = pageData[pageData.count - 1 - selectedIndex!].title ?? ""
            }
        }
        
    }

}
//Mark:- TableView Delegate, DataSource Method
extension ViewController:UITableViewDataSource, UITableViewDelegate{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1{
            return 40
        }
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1{
            let view = UINib(nibName: "HeaderView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! HeaderView
            view.clearButton.addTarget(self, action: #selector(ViewController.clearHistoryAction), for: .touchUpInside)
            return view
            
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let wikiVm = wikkiVM, let pageData = wikiVm.pageData, pageData.count > 0 && section == 1{
            return pageData.count
        }
        
        if let  wikiVm = wikkiVM, let wikiData = wikiVm.wikiModel, let query = wikiData.query, let pages = query.pages, pages.count > 0 && section == 0{
            return pages.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return wikkiVM.cellInstanceLoadData(tableView,indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    if let  wikiVm = wikkiVM, let wikiData = wikiVm.wikiModel, let query = wikiData.query, let pages = query.pages, pages.count > 0{
            wikkiVM.saveDataToDisk(page: pages[indexPath.row]) { (bool) in
                print(bool)
        }
    }
    selectedSection = indexPath.section
    selectedIndex = indexPath.row
    performSegue(withIdentifier: "send", sender: self)
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}

//Mark:- Search Delegate Method
extension ViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        wikkiVM.loadData(serachText: searchText) { (bool) in
            if bool{
                DispatchQueue.main.async{
                 self.searchTableView.reloadData()
                }
            }
        }
    }
    
}



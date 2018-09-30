//
//  WikiSearchVM.swift
//  WikiSearch
//
//  Created by user142467 on 9/30/18.
//  Copyright © 2018 user142467. All rights reserved.
//

import Foundation
import UIKit
protocol CellRepresentData: class{
    func cellInstanceLoadData(_ tableView:UITableView, _ indexPath:IndexPath) -> UITableViewCell
}

class WikiViewModel{
    
    var dataLayer:DataAccess
    var wikiModel:WikiSearchData?
    var pageData: [PageData]?
    
    init() {
       dataLayer = DataAccess()
    }
    
    
    func loadData(serachText:String,complete: @escaping ((Bool) -> Void)){
        
        self.dataLayer.loadSearchData(text: serachText) { (wiki) in
            
            guard let wiki = wiki else {
                complete(false)
                return
            }
            
            self.wikiModel = wiki
            complete(true)
        }
        
    }
    
    func fetchPersitedData(complete: @escaping ((Bool) -> Void)){
        self.dataLayer.loadPersistedData { (data) in
            
            guard let data = data else{
                complete(false)
                return
            }
            self.pageData = data
        }
    }
    
    func clearPersistedData(complete: @escaping ((Bool) -> Void)){
        self.dataLayer.deleteData { (bool) in
            complete(bool)
        }
        
        
    }
    
    
    func saveDataToDisk(page:Page, complete: @escaping ((Bool) -> Void)){
        dataLayer.saveData(page: page) { (bool) in
            if bool{
                complete(true)
            }
            complete(false)
        }
        
    }
    
    
}


extension WikiViewModel:CellRepresentData{
    func cellInstanceLoadData(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIndentifier, for: indexPath) as! SearchTableViewCell
        
        switch(indexPath.section){
        case 0:
            if let wikiData = self.wikiModel, let query = wikiData.query, let pages = query.pages, pages.count > 0 {
                do{
                    if let thumbnail = pages[indexPath.row].thumbnail, let source = thumbnail.source{
                        cell.searchImage.image = UIImage.init(data: try Data.init(contentsOf: URL.init(string:source)!))
                    }
                    
                }catch{
                    print(error.localizedDescription)
                }
                cell.titleText.text = pages[indexPath.row].title
                if let terms = pages[indexPath.row].terms, let description = terms.description, description.count > 0{
                    cell.descriptionText.text = description.first!.description
                    
                }
            }
        case 1:
          if let pageData = self.pageData, pageData.count > 0{
                do{
                    cell.searchImage.image = UIImage.init(data: try Data.init(contentsOf: URL.init(string: pageData[pageData.count - 1 - indexPath.row].imageUrl!)!))
                }catch{
                    print(error.localizedDescription)
                }
                cell.titleText.text = pageData[pageData.count - 1 - indexPath.row].title ?? ""
                cell.descriptionText.text = pageData[pageData.count - 1 - indexPath.row].pageDescription ?? ""
            }
            
            
        default :
            break
            
        }
        return cell
        
        
        
        
        
    }
    
}

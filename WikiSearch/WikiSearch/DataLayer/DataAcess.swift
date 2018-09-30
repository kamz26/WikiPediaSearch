//
//  DataAcess.swift
//  WikiSearch
//
//  Created by user142467 on 9/30/18.
//  Copyright © 2018 user142467. All rights reserved.
//

import Foundation
import CoreData


class DataAccess{    
    
    var context = CoreDataStack.shared.persistentContainer.viewContext
   
     func loadSearchData(text:String, complete: @escaping ((WikiSearchData?)-> Void)){
         let baseUrl = "https://en.wikipedia.org//w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description&gpssearch=\(text.formattedString())&gpslimit=10"
        let url = URL.init(string: baseUrl)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in            
             guard let data = data else {return }
            do{
                let searchResult = try JSONDecoder().decode(WikiSearchData.self, from: data)
                    //JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! [String:Any]
                print(searchResult)
                complete(searchResult)
            }catch{
                print(error.localizedDescription)
                complete(nil)
            }
        }
        task.resume()
       
    }
    
    func saveData(page:Page , complete: @escaping ((Bool) -> Void)){
        
        let pageData = PageData(context: context)
        pageData.title = page.title ?? ""
        pageData.pageDescription = page.terms?.description?.first ?? ""
        pageData.imageUrl = page.thumbnail!.source ?? ""
        CoreDataStack.shared.saveContext()
        
    }
    
    
    func deleteData(complete: @escaping ((Bool) -> Void)){
        
        let request:NSFetchRequest<PageData> = PageData.fetchRequest()
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request as! NSFetchRequest<NSFetchRequestResult>)
        
        do{
            try context.execute(deleteRequest)
            complete(true)
        }catch{
            print(error.localizedDescription)
            complete(false)
        }
    }
    
    func loadPersistedData(complete: @escaping (([PageData]?) -> Void)){
        
        let request:NSFetchRequest<PageData> = PageData.fetchRequest()
        
        do{
            let pageData = try context.fetch(request)
           complete(pageData)
            
        }catch{
            print(error.localizedDescription)
            complete(nil)
        }
    }
    
}

//
//  ViewController.swift
//  JsonApiDemo4
//
//  Created by Rachana Pandit on 22/11/22.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {

@IBOutlet weak var tblProductList:UITableView!
 var arrayProducts = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchingApiData()
        tableViewDataSourceAndDelegate()
        registerXib()
        tblProductList.estimatedRowHeight = 152
        tblProductList.rowHeight = UITableView.automaticDimension
    }
   func fetchingApiData()
    {
      let urlString = "https://fakestoreapi.com/products"
        
      let url = URL(string: urlString)
        
      var request = URLRequest(url: url!)
      request.httpMethod = "GET"
      let session = URLSession(configuration: .default)
        
        var dataTask = session.dataTask(with: request) { data, response, error in
            
            let getJsonObject = try! JSONSerialization.jsonObject(with: data!) as! [[String:Any]]
            
            for dictionary in getJsonObject{
                
                let eachDictionary = dictionary as [String:Any]
                
                let productId = eachDictionary["id"] as! Int
                let productTitle = eachDictionary["title"] as! String
                let productPrice = eachDictionary["price"] as! Double
                let productDecrip = eachDictionary["description"] as! String
                let productCategory = eachDictionary["category"] as! String
                let productImg = eachDictionary["image"] as! String
                
                let productRating =  eachDictionary["rating"] as! [String:Any]
                let productRate = productRating["rate"] as! Double
                let productCount = productRating["count"] as! Int
                
                self.arrayProducts.append(Product(id: productId,
                                title: productTitle,
                                price: productPrice,
                                description: productDecrip,
                                category: productCategory,
                                image: productImg,
                                rating: productRating,
                                rate: productRate,
                                count: productCount))
            }
            DispatchQueue.main.async {
                self.tblProductList.reloadData()
         }
    }
       dataTask.resume()
  }
    func tableViewDataSourceAndDelegate()
    {
        tblProductList.dataSource = self
        tblProductList.delegate = self
    }
    
    func registerXib()
    {
      let nibName = UINib(nibName: "TableViewCell", bundle: nil)
        tblProductList.register(nibName, forCellReuseIdentifier: "TableViewCell")
    }
}

extension ViewController:UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrayProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tblProductList.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        cell.lblId.text = String(arrayProducts[indexPath.row].id)
        cell.lblTitle.text = arrayProducts[indexPath.row].title
        cell.lblDescription.text = arrayProducts[indexPath.row].description
       // cell.lblCategory.text = arrayProducts[indexPath.row].category
        cell.lblCount.text = String(arrayProducts[indexPath.row].count)
        cell.lblRate.text = String(arrayProducts[indexPath.row].rate)
        let imgUrl = NSURL(string: self.arrayProducts[indexPath.row].image)
        cell.imgProduct.sd_setImage(with: imgUrl as URL?)
        cell.lblPrice.text =  String(arrayProducts[indexPath.row].price )
        return cell
    }
}

// MARK:- TableView Delegate Methods
extension ViewController:UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }

}

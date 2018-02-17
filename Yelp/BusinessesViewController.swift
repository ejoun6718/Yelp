//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
  
  @IBOutlet weak var tableView: UITableView!
  
  var businesses : [Business]!
  var searchBar : UISearchBar!
  var isMoreDataLoading = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 120
    
    searchBar = UISearchBar()
    searchBar.sizeToFit()
    navigationItem.titleView = searchBar
    
    Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
      
      self.businesses = businesses
      self.tableView.reloadData()
      if let businesses = businesses {
        for business in businesses {
          print(business.name!)
          print(business.address!)
        }
      }
      
    }
    )
    
    /* Example of Yelp search with more search options specified
     Business.searchWithTerm("Restaurants", sort: .distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: Error!) -> Void in
     self.businesses = businesses
     
     for business in businesses {
     print(business.name!)
     print(business.address!)
     }
     }
     */
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if businesses != nil {
      return businesses!.count
    }
    else {
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
    cell.business = businesses[indexPath.row]
    return cell
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if(!isMoreDataLoading) {
      let scrollViewContentHeight = tableView.contentSize.height
      let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
      
      if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
        isMoreDataLoading = true
      }
    }
  }
  
  /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let cell = sender as! UITableViewCell
    if let indexPath = tableView.indexPath(for: cell) {
      let business = businesses[indexPath.row]
      let mapViewController = segue.destination as! MapViewController
      mapViewController.address = business.address!
    }
  }*/
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let cell = sender as! UITableViewCell
    if let indexPath = tableView.indexPath(for: cell) {
      let business = businesses[indexPath.row]
      let detailsViewController = segue.destination as! DetailsViewController
      detailsViewController.business = business
    }
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath as IndexPath, animated: true)
  }
  
  /*func loadMoreData() {
    
    // ... Create the NSURLRequest (myRequest) ...
    
    // Configure session so that completion handler is executed on main UI thread
    let session = URLSession(configuration: URLSessionConfiguration.default,
                             delegate:nil,
                             delegateQueue:OperationQueue.main
    )
    let task : URLSessionDataTask = session.dataTask(with: myRequest, completionHandler: { (data, response, error) in
      
      // Update flag
      self.isMoreDataLoading = false
      
      // ... Use the new data to update the data source ...
      
      // Reload the tableView now that there is new data
      self.myTableView.reloadData()
    })
    task.resume()
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if (!isMoreDataLoading) {
      // Calculate the position of one screen length before the bottom of the results
      let scrollViewContentHeight = tableView.contentSize.height
      let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
      
      // When the user has scrolled past the threshold, start requesting
      if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
        
        isMoreDataLoading = true
        
        // Code to load more results
        loadMoreData()
      }
    }
  }*/
}

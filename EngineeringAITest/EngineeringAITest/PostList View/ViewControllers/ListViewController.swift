//
//  ViewController.swift
//  EngineeringAITest
//
//  Created by PCQ188 on 26/02/20.
//  Copyright © 2020 PCQ188. All rights reserved.
//

import UIKit
import Alamofire

final class ListViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var tableViewList: UITableView!
    
    //MARK: Variables
    private var arrHits: [Hits] = []
    private var currentPageNumber: Int = 0
    private var totalPage: Int = 0
    private var isLoadMore: Bool = false
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.handleRefresh), for: .valueChanged)
        refreshControl.tintColor = UIColor.gray
        return refreshControl
    }()

    //MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
    }
    
    //MARK: PrepareView
    private func prepareView() {
        self.tableViewList.refreshControl = refreshControl
        self.tableViewList.tableFooterView = UIView()
        
        //Cell Register
        self.tableViewList.register(UINib(nibName: String(describing: PostTableViewCell.self) , bundle: nil), forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        
        //api call
        callListApi(isShowLoader: true)
    }
    
    //MARK: Refresh
    @objc func handleRefresh() {
        self.currentPageNumber = 0
        self.callListApi(isShowLoader: false)
        self.refreshControl.endRefreshing()
    }
    
    //MARK: Set Table Header
    private func setTitle() {
        let selectedValue = self.arrHits.filter({$0.isSelected == true })
        if selectedValue.count < 2 {
            self.title = "Number of Post: \(selectedValue.count)"
        } else {
            self.title = "Number of Posts: \(selectedValue.count)"
        }
    }
    
    //MARK: Api Calling
    func callListApi(isShowLoader: Bool) {
        if isShowLoader == true {
            self.showProgressHud()
        }
        APIManager.shared.apiCallWithModelClass(request: .getListData(self.currentPageNumber), model: ListModel.self) { (status, responseData) in
            if status {
                if let apiResponse = responseData {
                    if let hits = apiResponse.hits {
                        if self.currentPageNumber == 0 {
                            self.arrHits.removeAll()
                        }
                        self.arrHits.append(contentsOf: hits)
                        self.totalPage = apiResponse.totalPages ?? 0
                        self.setTitle()
                        self.tableViewList.reloadData()
                        
                        if (self.currentPageNumber == (self.totalPage - 1)) {
                            self.isLoadMore = false
                        } else {
                            self.isLoadMore = true
                        }
                    }
                }
            }
            if isShowLoader == true {
                self.hideProgressHud()
            }
        }
    }
}

//MARK: TableView Delegate and DataSource

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return arrHits.count
        default:
            return isLoadMore ? 1 : 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as? PostTableViewCell ?? PostTableViewCell()
            cell.hit = arrHits[indexPath.row]
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "acitivityLoaderCell", for: indexPath) as? PostTableViewCell ?? PostTableViewCell()
            cell.activityIndicator.startAnimating()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if ((indexPath.row == self.arrHits.count - 1) && self.isLoadMore && refreshControl.isRefreshing == false && indexPath.section == 0)  {
            self.currentPageNumber += 1
            if self.currentPageNumber < self.totalPage {
                self.callListApi(isShowLoader: false)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            arrHits[indexPath.row].isSelected = !arrHits[indexPath.row].isSelected
            if let cell = tableView.cellForRow(at: indexPath) as? PostTableViewCell {
                cell.switchToggle.isOn = arrHits[indexPath.row].isSelected
            }
            self.setTitle()
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return UITableView.automaticDimension
        default:
            return (self.isLoadMore) ? 50 : 0
            
        }
    }
    
}

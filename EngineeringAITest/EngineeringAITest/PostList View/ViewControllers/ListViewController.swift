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
//        callListApi(isShowLoader: true)
    }
    
    @objc func handleRefresh() {
        
    }
    
    //MARK: Api Calling
    func callListApi(isShowLoader: Bool) {
        if isShowLoader == true {
            self.showProgressHud()
        }
        APIManager.shared.apiCallWithModelClass(request: .getListData(self.currentPageNumber), model: ListModel.self) { (status, responseData) in
            if status {
            }
        }
    }
}


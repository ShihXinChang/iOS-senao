//
//  ProductListViewController.swift
//  senao
//
//  Created by 張仕欣 on 2022/8/24.
//

import UIKit
import RxSwift
import MJRefresh

protocol ProductListViewControllerDelegate {
    func productListViewControllerDidSelectTableViewCell()
}

class ProductListViewController: UIViewController {
    private let searchController = UISearchController()
    
    @IBOutlet var tableView: UITableView!
    private var resourceArray: [ProductInfo] = []
    private var displayArray: [ProductInfo] = []
    
    var delegate: ProductListViewControllerDelegate?
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupUISearchController()
        setupTableView()
        
        bindObservable()
    }
}

// MARK: Private func
extension ProductListViewController {
    private func bindObservable() {
        let demoSubject = ProductInfoManager.shared.productArray_Subject
        _ = demoSubject.observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] productArray in
            guard let wealSelf = self else { return }
            wealSelf.resourceArray = productArray
            
            if let searchText = wealSelf.searchController.searchBar.text,
               searchText.isEmpty == false {
                wealSelf.displayArray = wealSelf.resourceArray.filter { $0.name.contains(searchText) }
            } else {
                wealSelf.displayArray = wealSelf.resourceArray
            }
            
            wealSelf.tableView.reloadData()
        })
    }
    
    // MARK: Task
    private func taskDemoProductList() {
        let observable = ModelHttpAPI.getDemoData()
        _ = observable.subscribe(onNext: { [weak self] () in
            guard let weakSelf = self else { return }
            weakSelf.resourceArray.removeAll()
        }, onDisposed: { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.mj_header?.endRefreshing()
        })
    }
}

extension ProductListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text,
           searchText.isEmpty == false {
            displayArray = resourceArray.filter { $0.name.contains(searchText) }
            tableView.reloadData()
        } else {
            displayArray = resourceArray
            tableView.reloadData()
        }
    }
}

extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductInfoCell", for: indexPath) as! ProductInfoCell
        cell.item = displayArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        ProductInfoManager.shared.selectedProductInfo = displayArray[indexPath.row]
        
        self.delegate?.productListViewControllerDidSelectTableViewCell()
    }
}


// MARK: custom UI
extension ProductListViewController {
    func setupUISearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "搜尋"
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "取消"
        searchController.searchBar.searchTextField.backgroundColor = .white
        searchController.searchBar.tintColor = .white
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let tableViewRefreshHeader = MJRefreshNormalHeader(refreshingBlock: {
            self.taskDemoProductList()
        })
        tableViewRefreshHeader.lastUpdatedTimeLabel?.isHidden = true
        tableViewRefreshHeader.stateLabel?.isHidden = true
        tableView.mj_header = tableViewRefreshHeader
        tableView.mj_header?.beginRefreshing()
    }
}

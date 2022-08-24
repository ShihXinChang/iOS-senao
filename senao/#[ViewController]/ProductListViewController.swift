//
//  ProductListViewController.swift
//  senao
//
//  Created by 張仕欣 on 2022/8/24.
//

import UIKit
import RxSwift

protocol ProductListViewControllerDelegate {
    func productListViewControllerDidSelectTable()
}

class ProductListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    private var productArray: [ProductInfo] = []
    
    var delegate: ProductListViewControllerDelegate?
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        bindObservable()
        taskDemoProductList()
    }
}

// MARK: Private func
extension ProductListViewController {
    private func bindObservable() {
        let demoSubject = ProductInfoManager.shared.productArray_Subject
        _ = demoSubject.observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] productArray in
            guard let wealSelf = self else { return }
            wealSelf.productArray = productArray
            wealSelf.tableView.reloadData()
        })
    }
    
    // MARK: Task
    private func taskDemoProductList() {
        let observable = ModelHttpAPI.getDemoData()
        _ = observable.subscribe(onNext: { [weak self] () in
            guard let weakSelf = self else { return }
            weakSelf.productArray.removeAll()
        }, onDisposed: {
            
        })
    }
}

extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductInfoCell") as! ProductInfoCell
        cell.item = productArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        ProductInfoManager.shared.selectedProductInfo = productArray[indexPath.row]
        self.delegate?.productListViewControllerDidSelectTable()
    }
}

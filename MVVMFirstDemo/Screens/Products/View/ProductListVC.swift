//
//  ProductListVC.swift
//  MVVMFirstDemo
//
//  Created by Apple on 23/09/24.

//TODO: - [weak self] <- use for Memory if event is nil or not nill optional
//TODO: -  dataBinding event observer   <- Communication

import UIKit

class ProductListVC: UIViewController {

    @IBOutlet weak var tblProductList: UITableView!
    private var viewModel = ProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configuration()
    }
}
extension ProductListVC{
    
    func configuration(){
    
        self.tblProductList.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        self.tblProductList.delegate = self
        self.tblProductList.dataSource = self
        initViewModel()
        observeEvent()
        
    }
    func initViewModel(){
        viewModel.fetchProduct()
    }
    //TODO: - dataBinding event observe   <- Communication
    func observeEvent(){
        viewModel.eventHandler = { [weak self] event in
            guard let self else {
                return
            }
            switch event{
            case .loading:
                //Indicator show
               print("Product Loading...")
            case .stopLoading:
                //Indicator Hide
                print("Product Stop Loading..")
            case .dataLoaded:
                print("Data Loaded..")
                print(self.viewModel.arrProductModel)
                
                //MARK: - Main Thread UI reloading Data -> UI related Work -- It's work well in main
                DispatchQueue.main.async {
                    self.tblProductList.reloadData()
                }
                
            case .error(let error):
                print(error?.localizedDescription)
                break
            }
        }
    }
}
//MARK: - UITableViewDelegate UITableViewDelegate
extension ProductListVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrProductModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tblProductList.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)as? ProductCell
        else{
           return UITableViewCell()
       }
        let product  = viewModel.arrProductModel[indexPath.row]
        cell.product = product
        return cell
    }

}

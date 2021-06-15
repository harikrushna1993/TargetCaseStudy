//
//  ProductListViewController.swift
//  ProductViewer
//
//  Created by Harikrushna Sahu on 13/06/21.
//  Copyright © 2021 Target. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController {
    @IBOutlet weak var collectionViewProductList: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    class func viewControllerFor() -> ProductListViewController? {
        if let listVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProductListViewController") as? ProductListViewController {
            return listVC
        }
        return nil
    }
    
    private var productListViewModel = ProductListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataSouce()
        fetchProductList()
    }
    
    private func setupDataSouce() {
        collectionViewProductList.dataSource = self
        collectionViewProductList.delegate = self
        collectionViewProductList.register(UINib(nibName: "ProductListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductListCollectionViewCell")
    }
    
    private func fetchProductList() {
        showActivityIndicator(status: true)
        productListViewModel.getProductList() { [weak self] (status, error) in
            DispatchQueue.main.async {
                self?.showActivityIndicator(status: false)
                guard status, error == nil else {
                    self?.showErrorMessage(error)
                    return
                }
                self?.collectionViewProductList.reloadData()
            }
        }
    }
        
    private func showErrorMessage(_ error: Error?) {
        
        let alertController = UIAlertController(title: "error", message: error?.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Retry", style: UIAlertAction.Style.default) { [self]
            UIAlertAction in
            self.fetchProductList()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func showActivityIndicator(status: Bool) {
        if status {
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        } else {
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        }
    }
    
}

extension ProductListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productListViewModel.productListCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductListCollectionViewCell", for: indexPath) as? ProductListCollectionViewCell else { return UICollectionViewCell() }
        if let content = productListViewModel.contentItems?[indexPath.row] {
            cell.loadContentDetail(contentItem: content)
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard  let detailVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProductDetailViewController") as? ProductDetailViewController else { return }
        if let content = productListViewModel.contentItems?[indexPath.row] {
            detailVC.product = content
        }
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 155)
    }
    
}

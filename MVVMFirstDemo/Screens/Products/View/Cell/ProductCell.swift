//
//  ProductCell.swift
//  MVVMFirstDemo
//
//  Created by Apple on 23/09/24.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var imgProduct        : UIImageView!
    @IBOutlet weak var bgProductview     : UIView!
    @IBOutlet weak var lblTitleProduct   : UILabel!
    @IBOutlet weak var lblProductCategory: UILabel!
    @IBOutlet weak var lblDesc           : UILabel!
    @IBOutlet weak var lblPrice          : UILabel!
    @IBOutlet weak var RateButton        : UIButton!
    
    var product:ProductDataModel?{
         
        didSet{ //TODO: - Property Observer
            productDetailsConfig()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func productDetailsConfig(){
        guard let product else {
            return
        }
        lblTitleProduct.text     =  product.title
        lblDesc.text             =  product.description
        lblProductCategory.text  = product.category
        lblPrice.text            =  "$\(product.price!)"
        RateButton.setTitle("\(product.rating.rate!)", for: .normal)
        self.imgProduct.setImage(with: product.image)
    }
    
}

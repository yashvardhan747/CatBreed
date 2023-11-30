//
//  TitleValueTableViewCell.swift
//  CatBreeds
//
//  Created by Yash on 29/11/23.
//

import UIKit

class TitleValueTableViewCell: UITableViewCell {

    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var cellValueLabel: UILabel!
    
    private var viewModel: TitleValueTableViewCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(_ viewModel: TitleValueTableViewCellViewModel) {
        cellTitleLabel.text = viewModel.dataTitle
        cellValueLabel.text = viewModel.dataValue
    }
    
    
}

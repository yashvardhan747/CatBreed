//
//  TitleValueTableViewCell.swift
//  CatBreeds
//
//  Created by Astrotalk on 29/11/23.
//

import UIKit

class TitleValueTableViewCell: UITableViewCell {

    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var cellValueLabel: UILabel!
    
    private var viewModel: Title_ValueTableViewCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(_ viewModel: Title_ValueTableViewCellViewModel) {
        cellTitleLabel.text = viewModel.dataTitle
        cellValueLabel.text = viewModel.dataValue
    }
    
    
}

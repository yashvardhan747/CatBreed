//
//  ImageTitleSubTitleTableViewCell.swift
//  CatBreeds
//
//  Created by Astrotalk on 29/11/23.
//

import UIKit

class ImageTitleSubTitleTableViewCell: UITableViewCell {
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var cellSubTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with viewModel: Image_Title_SubTitleTableViewCellViewModel) {
        cellTitleLabel.text = viewModel.getTitle
        cellSubTitleLabel.text = viewModel.getValue
        
    cellImageView.setAndSaveImage(urlString: viewModel.getImageUrl, name: viewModel.getTitle)
    }
}

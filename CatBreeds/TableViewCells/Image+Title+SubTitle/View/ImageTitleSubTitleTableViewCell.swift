//
//  ImageTitleSubTitleTableViewCell.swift
//  CatBreeds
//
//  Created by Yash on 29/11/23.
//

import UIKit

class ImageTitleSubTitleTableViewCell: UITableViewCell {
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var cellSubTitleLabel: UILabel!
    
    private var viewModel: ImageTitleSubTitleTableViewCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with viewModel: ImageTitleSubTitleTableViewCellViewModel) {
        self.viewModel = viewModel
        cellTitleLabel.text = viewModel.getTitle
        cellSubTitleLabel.text = viewModel.getValue
        
        cellImageView.setAndSaveImage(referenceImageId: viewModel.getReferenceImageId)
    }
    
    func reloadImageView() {
        guard let viewModel = viewModel else {return}
        cellImageView.setAndSaveImage(referenceImageId: viewModel.getReferenceImageId)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellImageView.image = nil
    }
}


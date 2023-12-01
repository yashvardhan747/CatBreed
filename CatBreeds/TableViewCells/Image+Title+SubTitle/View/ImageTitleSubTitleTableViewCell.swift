//
//  ImageTitleSubTitleTableViewCell.swift
//  CatBreeds
//
//  Created by Yash on 29/11/23.
//

import UIKit

protocol ImageTitleSubTitleTableViewCellDelegate: AnyObject {
    func reloadImageView(for index: Int)
}

class ImageTitleSubTitleTableViewCell: UITableViewCell {
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var cellSubTitleLabel: UILabel!
    @IBOutlet weak var reloadImageViewButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    weak var delegate: ImageTitleSubTitleTableViewCellDelegate?
    
    private var viewModel: ImageTitleSubTitleTableViewCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        reloadImageViewButton.addTarget(self, action: #selector(reloadImageViewButtonTapped), for: .touchUpInside)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellImageView.image = nil
    }
    
    func configure(with viewModel: ImageTitleSubTitleTableViewCellViewModel) {
        self.viewModel = viewModel
        cellTitleLabel.text = viewModel.getTitle
        cellSubTitleLabel.text = viewModel.getValue
        
        loadImageView()
    }
    
    private func loadImageView(){
        guard let viewModel = viewModel else {return}
        
        switch viewModel.imageFetchingStatus {
        case .failed:
            self.reloadImageViewButton.isHidden = false
            self.activityIndicator.isHidden = true
        case.fetched(let fetchable):
            cellImageView.setAndSaveImage(imageUrlString: fetchable.urlString, imageName: viewModel.getTitle) {bool in
                switch bool {
                case true:
                    self.reloadImageViewButton.isHidden = true
                    self.activityIndicator.isHidden = true
                case false:
                    self.reloadImageViewButton.isHidden = false
                    self.activityIndicator.isHidden = true
                }
            }
        case .fetching:
            self.reloadImageViewButton.isHidden = true
            self.activityIndicator.isHidden = false
        case .notStarted:
            self.reloadImageViewButton.isHidden = true
            self.activityIndicator.isHidden = false
        }
    }
    
    @objc private func reloadImageViewButtonTapped() {
        guard let index = viewModel?.index else {return}
        delegate?.reloadImageView(for: index)
    }
    
}


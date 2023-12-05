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

final class ImageTitleSubTitleTableViewCell: UITableViewCell {
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
    
    private func hideSpinner() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }
    
    private func showSpinner() {
        self.activityIndicator.startAnimating()
        self.activityIndicator.isHidden = false
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellImageView.image = nil
        self.reloadImageViewButton.isHidden = true
        showSpinner()
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
            hideSpinner()
        case.fetched(let fetchable):
            cellImageView.setAndSaveImage(imageUrlString: fetchable.urlString, imageName: viewModel.getTitle) {bool in
                switch bool {
                case true:
                    self.reloadImageViewButton.isHidden = true
                    self.hideSpinner()
                case false:
                    self.reloadImageViewButton.isHidden = false
                    self.hideSpinner()
                }
            }
        case .fetching, .notStarted:
            self.reloadImageViewButton.isHidden = true
            self.showSpinner()
        }
    }
    
    @objc private func reloadImageViewButtonTapped() {
        guard let index = viewModel?.index else {return}
        delegate?.reloadImageView(for: index)
    }
    
}


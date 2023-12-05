//
//  BreedDetailViewController.swift
//  CatBreeds
//
//  Created by Yash on 29/11/23.
//
import UIKit

final class BreedDetailViewController: UIViewController {

    @IBOutlet weak var breedImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var reloadImageButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let viewModel: BreedDetailViewModel
    
    init?(coder: NSCoder, viewModel: BreedDetailViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
      }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.title = viewModel.name
    }
    
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Constants.TableViewCellIdentifier.TitleValueTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.TableViewCellIdentifier.TitleValueTableViewCell)
        
        loadImage()
        reloadImageButton.addTarget(self, action: #selector(reloadImageButtonTapped), for: .touchUpInside)
    }
    
    @objc private func reloadImageButtonTapped() {
        viewModel.fetchImageUrl()
    }
    
    private func hideSpinner() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }
    
    private func showSpinner() {
        self.activityIndicator.startAnimating()
        self.activityIndicator.isHidden = false
    }
    
    private func loadImage() {
        switch viewModel.imageURLFetchingStatus {
        case .failed:
            reloadImageButton.isHidden = false
            hideSpinner()
        case .fetching, .notStarted:
            reloadImageButton.isHidden = true
            showSpinner()
        case .fetched(let breedImage):
            breedImageView.setAndSaveImage(imageUrlString: breedImage.urlString, imageName: viewModel.name) {[weak self] bool in
                switch bool {
                case true:
                    self?.reloadImageButton.isHidden = true
                    self?.hideSpinner()
                case false:
                    self?.reloadImageButton.isHidden = false
                    self?.hideSpinner()
                }
            }
        }
    }
    
    deinit {
        BreedImageUrlFetcher.shared.delegates = BreedImageUrlFetcher.shared.delegates.filter { delegate in
            guard let viewModel = delegate as? BreedDetailViewModel, viewModel.index == self.viewModel.index else {
                return true
            }
            return false
        }
    }
    
}

//MARK: - TableView Delegate and DataSource
extension BreedDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.tableRepresentaionCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCellIdentifier.TitleValueTableViewCell, for: indexPath) as? TitleValueTableViewCell else {return UITableViewCell()}
        
        let rowData = viewModel.getBreedMetaData(at: indexPath.row)
        cell.configure(TitleValueTableViewCellViewModel(TitleValueTableViewCellModel(title: rowData.title, value: rowData.value)))
        return cell
    }
}

//MARK: - BreedDetailViewModelDelegate
extension BreedDetailViewController: BreedDetailViewModelDelegate {
    func reloadImageView() {
        loadImage()
    }
}

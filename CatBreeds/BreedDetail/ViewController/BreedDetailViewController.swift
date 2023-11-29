//
//  BreedDetailViewController.swift
//  CatBreeds
//
//  Created by Astrotalk on 29/11/23.
//
import UIKit

final class BreedDetailViewController: UIViewController {

    @IBOutlet weak var breedImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel: BreedDetailViewModel
    
    init?(coder: NSCoder, viewModel: BreedDetailViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
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
        breedImageView.setAndSaveImage(urlString: viewModel.imageUrlString, name: viewModel.id)
    }
}

extension BreedDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.tableRepresentaionCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCellIdentifier.TitleValueTableViewCell, for: indexPath) as? TitleValueTableViewCell else {return UITableViewCell()}
        
        let rowData = viewModel.getBreedMetaData(at: indexPath.row)
        cell.configure(Title_ValueTableViewCellViewModel(Title_ValueTableViewCellModel(title: rowData.title, value: rowData.value)))
        return cell
    }
}



//
//  Constants.swift
//  CatBreeds
//
//  Created by Yash on 29/11/23.
//

enum Constants {
    
    enum StoryBoardIdentifiers {
        enum BreedScreens {
            static let identifier = "BreedScreens"
            enum ViewControllerIdentiers {
                static let BreedsViewController = "BreedsViewController"
                static let BreedDetailViewController = "BreedDetailViewController"
            }
        }
    }
    
    enum TableViewCellIdentifier {
        static let ImageTitleSubTitleTableViewCell = "ImageTitleSubTitleTableViewCell"
        static let TitleValueTableViewCell = "TitleValueTableViewCell"
    }
   
    enum PersistencyManagerFileNames {
        static let Breeds = "Breeds"
    }
    
    enum ImageTitle {
        static let placeholderCat = "placeholderCat"
    }
}

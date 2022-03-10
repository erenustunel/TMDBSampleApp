//
//  TableView+Extension.swift
//  MovieApp
//
//  Created by Eren Üstünel on 10.12.2021.
//
import Foundation
import UIKit

public extension UITableView {
    func registerCells(_ cells: [UITableViewCell.Type]) {
        for cell in cells {
            register(nibFromClass(cell), forCellReuseIdentifier: cell.nameOfClass)
        }
    }

    fileprivate func nibFromClass(_ type: UIView.Type) -> UINib {
        return UINib(nibName: type.nameOfClass, bundle: nil)
    }
}

//
//  SampleCollectionViewCell.swift
//  UICollectionSample
//
//  Created by 山崎定知 on 2022/12/01.
//

import UIKit

class SampleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .lightGray
    }

}

//
//  ViewController.swift
//  UICollectionSample
//
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    let items = ["改める", "土左衛門", "地縛霊", "駅前寿司",
                 "ファインダー", "鳥", "高速道路", "鶴岡八幡宮", "インスタグラマー", "滝", "日本",
                 "野球", "ボディ・ランゲージ", "飛び出す絵本", "街", "原材料",
                 "とんとん拍子", "ポートフォリオ", "にく", "刹那", "縫い糸", "魚",
                 "チャイルドシート", "友達", "蜂", "弁護士", "伝統芸能", "知ったかぶり", "劇場版",
                 "民衆", "ワニ", "ユニコード", "消しゴム付き鉛筆"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: String(describing: SampleCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: SampleCollectionViewCell.self))
        
        let customCollecttionViewLayout = CustomCollecttionViewLayout()
        customCollecttionViewLayout.delegate = self
        collectionView.collectionViewLayout = customCollecttionViewLayout
    }
}

extension ViewController: CustomCollectionViewLayoutDelegate {
    func customCollectionViewLayout(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = items[indexPath.row]
        label.sizeToFit()
        let size = label.frame.size
        return size
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SampleCollectionViewCell", for: indexPath) as! SampleCollectionViewCell
        cell.label.font = UIFont.systemFont(ofSize: 14)
        cell.label.text = self.items[indexPath.row]
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 10
        return cell
    }
}

class CustomCollecttionViewLayout: UICollectionViewLayout {
    weak var delegate: CustomCollectionViewLayoutDelegate!
    var padding: CGFloat = 3
    var attributesArray = [UICollectionViewLayoutAttributes]()
    var contentHeight: CGFloat {
        get {
            guard let collectionView = collectionView else { return 0 }
            return collectionView.bounds.height
        }
        set { }

    }
     var contentWidth: CGFloat {
         guard let collectionView = collectionView else { return 0 }
         return collectionView.bounds.width
     }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        guard attributesArray.isEmpty, let collectionView = collectionView else { return }

        var leftMargin: CGFloat = 5.0
        var maxY: CGFloat = -1

            for item in 0..<collectionView.numberOfItems(inSection: 0) {
                let indexPath = IndexPath(item: item, section: 0)
                let size = delegate.customCollectionViewLayout(collectionView, cellForItemAt: indexPath)
                
                if size.width > contentWidth - leftMargin {
                    maxY += size.height + 2
                    leftMargin = 5.0
                }
                
                
                let frame = CGRect(x: leftMargin, y: maxY, width: delegate.customCollectionViewLayout(collectionView, cellForItemAt: indexPath).width, height: size.height)
//                let insetNewFrame = newFrame.insetBy(dx: padding, dy: padding)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = frame
                attributesArray.append(attributes)
                leftMargin += size.width + 5
            }
        }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()

        for attributes in attributesArray {
            visibleLayoutAttributes.append(attributes)
        }
        return visibleLayoutAttributes
    }
}

protocol CustomCollectionViewLayoutDelegate: AnyObject {
    func customCollectionViewLayout(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> CGSize
}

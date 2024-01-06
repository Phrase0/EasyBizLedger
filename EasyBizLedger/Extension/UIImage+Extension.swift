//
//  UIImage+Extension.swift
//  EasyBizLedger
//
//  Created by Peiyun on 2023/12/26.
//

import UIKit

enum ImageAsset: String {
    case chatroom = "text.bubble.fill"
    case cCircle = "c.circle"
    case checkmark
    case checkmarkSquare = "checkmark.square"
    case clock = "clock.fill"
    case flag
    case heart
    case history = "clock.arrow.circlepath"
    case house
    case enlarge = "arrow.up.left.and.arrow.down.right"
    case magnifyingglass
    case nosign
    case pause = "pause.fill"
    case pencil
    case person
    case personalPicture = "person.crop.circle"
    case play = "play.fill"
    case playCircle = "play.circle"
    case plus
    case searchArrow = "arrow.up.backward"
    case selectedHeart = "heart.fill"
    case selectedHouse = "house.fill"
    case selectedMagnifyingglass
    case selectedPerson = "person.fill"
    case paperplane
    case shrink = "arrow.down.right.and.arrow.up.left"
    case square
    case submitDanMu = "ellipsis.message.fill"
    case thumbImage = "circle.fill"
    case trash = "trash.fill"
    case xmark
}

extension UIImage {
    static func systemAsset(
        _ asset: ImageAsset,
        configuration: UIImage.Configuration? = nil
    ) -> UIImage {
        if let image = UIImage(systemName: asset.rawValue, withConfiguration: configuration) {
            return image
        } else {
            return UIImage()
        }
    }
}
